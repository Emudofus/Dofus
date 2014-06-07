package haxe.ds
{
   public class GenericCell_Int extends Object
   {
      
      public function GenericCell_Int(param1:int, param2:GenericCell_Int) {
         elt = param1;
         next = param2;
      }
      
      public var next:GenericCell_Int;
      
      public var elt:int;
   }
}
