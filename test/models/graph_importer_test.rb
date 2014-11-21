class GraphImporterTest < ActiveSupport::TestCase
  def setup
    @graph = Graph.new(Concept.all)
    @graph_importer = GraphImporter.new(@graph)
  end

  def test_import_with_nothing
    assert_difference('Concept.count', 0) do
      @graph_importer.import_new_nodes("")
    end
  end

  def test_import_with_one
    @graph_importer.import_new_nodes('TestA // Is Awesome')
    assert_equal concepts(:TestA).description, "Is Awesome"
  end

  def test_import_with_name_only
    @graph_importer.import_new_nodes('TestB')
    assert_equal concepts(:TestB).description, nil
  end

  def test_import_with_many_roots
    assert_difference('Concept.count', 2) do
      @graph_importer.import_new_nodes(%q{
TestC // Is Root
TestD // Is Root
})
    end
    assert_equal concepts(:TestD).description, "Is Root"
    assert concepts(:TestD).child_concepts.blank?
  end

  def test_import_with_children_and_second_root
    assert_difference('Concept.count', 4) do
      @graph_importer.import_new_nodes(%q{
TestE // Is Root
 TestF // Is Child
  TestG // Is Grandchild
TestH // Is Root
})
    end
    assert_equal concepts(:TestF).description, "Is Child"
    assert_equal concepts(:TestF).child_concepts.length, 1
    assert_equal concepts(:TestF).child_concepts[0].description, "Is Grandchild"
    assert_equal concepts(:TestF).parent_concept.blank?, false
    assert_equal concepts(:TestF).parent_concept.description, "Is Root"
    assert_equal concepts(:TestH).description, "Is Root"
    assert_equal concepts(:TestH).parent_concept.blank?, true
  end

  def test_import_with_implementations
    assert_difference('Concept.count', 2) do
      @graph_importer.import_new_nodes(%q{
TestI // Is Root
 * TestJ // Is Implementation
})
    end
    assert_equal concepts(:TestI).implementations.length, 1
    assert_equal concepts(:TestI).implementations[0].name, "TestJ"
    assert_equal concepts(:TestI).implementations[0].theory.description, "Is Root"
  end

  def test_import_with_root_implementations
    @graph_importer.import_new_nodes(%q{
* Test // Is Root
})
    assert_nil concepts(:"* Test1")
  end

  def test_import_with_duplicate_names
    assert_difference('Concept.count', 0) do
      assert_raises(Neo4j::ActiveNode::Persistence::RecordInvalidError) {
        @graph_importer.import_new_nodes(%q{
Test1 // Is Root
Test1 // Is a Duplicate Name
})
      }
    end
  end

  def test_import_with_too_much_indentation
    assert_difference('Concept.count', 0) do
      assert_raises(RuntimeError) {
        @graph_importer.import_new_nodes(%q{
Test1 // Is Root
   Test2 // Is Too Indented
})
      }
    end
  end
end
