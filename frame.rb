#!/usr/bin/env ruby

class TreeNode
    attr_reader :name, :children, :parent

    def initialize(name, parent = nil)
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
        child = TreeNode.new(name, self);
        @children.insert(pos, child)
        child
    end

    def rename(name)
        @name = name
    end

    def move_nextto(target)
        if (@parent == nil)
            return nil;
        end

        if (target.parent == nil)
            raise "Can't have two heads"
        end

        print self; #DEBUG
        puts;
        
        # remove first 
        src = @parent.children.index(self);
        @parent.children.delete_at(src);

        print src; #DEBUG
        puts;

        # copy first
        dest = target.parent.children.index(target);
        target.parent.children.insert(dest + 1, self);

        # adjust parent
        @parent = target;
    end
    
    def move_under(target)
        if (@parent == nil)
            return nil;
        end

        src = @parent.children.index(self);

        # copy first
        target.children.insert(0, self);

        # remove deprecated
        @parent.children.delete_at(src);

        # adjust parent
        @parent = target;
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
        if File.readable?(fname)
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

    a2.move_nextto(a);
    a2.move_nextto(c);

    TreeNode._traverse(head, 0);
end
