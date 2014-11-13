class Concept
  include Neo4j::ActiveNode
  property :name, type: String
  property :description, type: String
  property :updated_at, type: DateTime #Automatically set
  property :created_at, type: DateTime #Automatically set

  validates :name, presence: true, uniqueness: true
  index :name

  #TODO: Validate assumption of no loops.
  has_many :out, :subsequents, model_class: self, type: 'precedes'
  has_many :in, :precedents, model_class: self, origin: :subsequents

  has_many :out, :implementations, model_class: self, type: 'implements'
  has_one  :in, :theory, model_class: self, origin: :implementations

  has_many :out, :child_concepts, model_class: self, type: 'contains'
  has_one  :in, :parent_concept, model_class: self, origin: :child_concepts

  def references
    Reference.where(concept_uuid: uuid).where.not(concept_uuid: nil)
  end

  def to_hash
    {uuid: uuid,
     name: name,
     precedence_depth: precedence_depth,
     children: child_concepts.map(&:to_hash)}
  end

  def precedence_depth
    return 0 if precedents.blank?
    depths = precedents.map(&:precedence_depth)
    depths.max + 1
  end

  def subsequence_structure
    subsequents.map do |s|
      {source: self, target: s}
    end
  end

  # TODO: Break these three out in the spirit of POODR.
  def self.import_nodes(node_text)
    begin
      tx = Neo4j::Transaction.new
      stack = []
      node_text.each_line do |line|
        next if line.blank?
        depth = line[/\A */].size

        raise "Indentation too rapid on '#{line}'" if depth > stack.length + 1

        clauses = line.strip.split(' // ')
        stack[depth] = Concept.create!(name: clauses[0], description: clauses[1])
        if depth > 0
          stack[depth-1].child_concepts << stack[depth]
        end
      end
    rescue
      tx.failure
      raise
    ensure
      tx.close
    end
  end

  def self.import_relationships(text, association_name = "subsequents")
    text.each_line do |line|
      next if line.blank?
      clauses = line.strip.split(' -> ')
      where(name: clauses[0]).first.send(association_name) <<
        where(name: clauses[1]).first
    end
  end
end
