require 'cabocha'

# 日本語係り受け解析器 CaboCha Ruby 拡張の基本的な使い方とちょっとした応用
# http://ultraist.hatenablog.com/entry/20111015/1318662808
module CaboCha
  # 文
  class Tree
    # @param position [Fixnum]
    def chunk_with_set_tree position
      chunk = chunk_without_set_tree position
      chunk.tree = self
      chunk
    end
    alias_method :chunk_without_set_tree, :chunk
    alias_method :chunk, :chunk_with_set_tree

    def chunks
      chunk_size.times.map { |i| chunk i }
    end
  end

  # 文節
  class Chunk
    attr_accessor :tree

    def tokens
      token_size.times.map { |i| tree.token(token_pos + i) }
    end

    def next_chunk
      link >= 0 ? tree.chunk(link) : nil
    end
  end

  # 詞辞
  class Token
    # @param position [Fixnum]
    def feature_list_with_encode position
      feature_list_without_encode(position).force_encoding 'utf-8'
    end
    alias_method :feature_list_without_encode, :feature_list
    alias_method :feature_list, :feature_list_with_encode

    def features
      feature_list_size.times.map { |i| feature_list i }
    end

    def noun?
      feature_list(0) == '名詞'
    end

    def verb?
      feature_list(0) == '動詞'
    end

    # 基本形
    def to_base
      if feature_list_size > 6 && feature_list(6) != '*'
        feature_list(6).force_encoding('utf-8')
      else
        normalized_surface
      end
    end
  end
end
