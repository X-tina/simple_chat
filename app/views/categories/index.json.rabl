object @categories

node(:meta) do 
             {
                success: true,

                count: 1,
                total_count: 1
              }
            end
child({:@categories => :data}, { object_root: false }) do
  extends('categories/_category')
end
