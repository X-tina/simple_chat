object @users

node(:meta) do 
             {
                success: true,
              }
            end
child({:@users => :data}, { object_root: false }) do
  extends('users/_user')
end