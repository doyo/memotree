#!/usr/bin/env ruby

class TreeNode
    attr_reader :name, :children, :parent, :index

    def initialize(name)
        @name = name
        @children = []
        @parent = parent
    end

    def self._traverse(node, depth)
        if node == nil
#            puts "#{depth}\n"
        else
            for i in (0 .. depth - 1)
                print "\t"
            end

            puts "#{node.name}"

            node.children.each { |child| TreeNode._traverse(child, depth + 1) }
        end
    end

    def spawn(name, pos = -1)
        child = TreeNode.new(name);
        @children.insert(pos, child)
        child
    end

    def rename(name)
        @name = name
    end

    def move_after(target)
        target_parent = target.parent;
    end
    def move_before(target)
        raise "Not implemented yet.";
    end
    def move_under(target)
        raise "Not implemented yet.";
    end
end

class MindTree
    def initialize(id)
        @id = id
        @tree = nil
    end

    def load()
        node = TreeNode.new(@id)

        fname = "data/#{@id}.txt"
        if File.readable? (fname)
            f = File.new(fname)
            while (line = f.gets)
            
            end
            f.close
#        else
#            f = File.new(fname, File::CREAT|File::RDWR, 0644)
#            puts "yeah it's nil\n"
        end

        node
    end
end


if __FILE__ == $0
    tree = MindTree.new(100)
    head = tree.load

    a = head.spawn("a");
    b = head.spawn("b");
    c = head.spawn("c");

        a1 = a.spawn("a1");
        a2 = a.spawn("a2");
            a21 = a2.spawn("trash");
        a3 = a.spawn("a3");

        c1 = c.spawn("c1");
        c2 = c.spawn("c2");

    a21.rename("a21");

    a2.move_after(c1);

    TreeNode._traverse(head, 0);
end
