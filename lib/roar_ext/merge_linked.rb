module RoarExt
  module MergeLinked
    # Hacks around a bug in roar which does not match JSONAPI when
    # using the `linked` resources feature.
    #
    # @example Before & after
    #   representation = {
    #     'widgets' => {},
    #     'linked' => { 'owners' => [{'owners'=>{'id'=>1}}, {'owners'=>{'id'=>2}}] }
    #   }
    #
    #   RoarExt::MergeLinked.flatten(representation)['linked']
    #   #=> { 'owners' => [{ 'id'=>1 }, {'id' => 2}] }
    # @todo Send a PR to fix this upstream; not easy to fix in roar, tho.
    def self.flatten(representation)
      return representation unless linked = representation['linked']

      representation['linked'] = linked.each_with_object({}) do |(key, ary), acc|
        if ary.all? { |hash| hash.kind_of?(Hash) && hash.keys == [key] }
          acc[key] = ary.map { |hash| hash.values.first }.uniq { |rec| rec['id'] }
        else
          acc[key] = ary
        end
      end

      representation
    end
  end
end
