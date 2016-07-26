object false

node(:meta) do 
             {
                success: true,

                count: 1,
                total_count: 1
              }
            end
child({:@images => :data}, { object_root: false }) do
  extends('images/_image')
end
