node(:image) { |object| 
                       {
                         id: object.id,
                         url: object.url,
                         text: object.text,
                         created_at: object.created_at,
                         updated_at: object.updated_at
                       }

            }
