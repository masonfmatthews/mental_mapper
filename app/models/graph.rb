class Graph
  attr_accessor :relation, :nodes

  def initialize(rel)
    @relation = rel
    @nodes = rel.to_a
    @parentage_depths = {}
    @precedence_depths = {}
  end

  def destroy
    nodes.each &:destroy
    nodes = relation.to_a
    @roots = nil
  end

  # TODO: Write query with Cypher
  def root_nodes
    @roots ||= nodes.select {|c| c.parent_concept.blank? && c.theory.blank? }
  end

  def ancestry_structure
    root_nodes.map {|r| r.to_hash(self)}
  end

  def subsequence_structure
    root_nodes.map(&:subsequence_structure).flatten
  end

  def all_link_structure
    nodes.map(&:all_links).flatten
  end

  def parentage_depth(node)
    @parentage_depths[node] ||= node.parentage_depth(self)
  end

  def precedence_depth(node)
    @precedence_depths[node] ||= node.precedence_depth(self)
  end

  def create_concept(attr)
    new_concept = Concept.create!(attr)
    nodes << new_concept
    new_concept
  end

  def create_relationship_by_names(source, target, association)
    source_concept = relation.where(name: source).first
    target_concept = relation.where(name: target).first
    raise "'#{source}' not present in graph." unless source_concept
    raise "'#{target}' not present in graph." unless target_concept
    source_concept.send(association) << target_concept
  end
end
