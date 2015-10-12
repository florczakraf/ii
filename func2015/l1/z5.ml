let rec f a = a :: (f a);;
List.hd (f 1);;
