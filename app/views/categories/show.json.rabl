object @category

node(:meta) do 
             {
                success: true,

                count: 1,
                total_count: 1
              }
            end
child({:@category => :data}, { object_root: false }) do
  extends('categories/_category')
end