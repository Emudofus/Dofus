package haxe.ds
{
   public class GenericStack_Int extends Object
   {
      
      public function GenericStack_Int() {
      }
      
      public function toString() : String {
         var _loc1_:Array = [];
         var _loc2_:GenericCell_Int = head;
         while(_loc2_ != null)
         {
            _loc1_.push(_loc2_.elt);
            _loc2_ = _loc2_.next;
         }
         return "{" + _loc1_.join(",") + "}";
      }
      
      public function remove(param1:int) : Boolean {
         var _loc2_:* = null;
         var _loc3_:GenericCell_Int = head;
         while(_loc3_ != null)
         {
            if(_loc3_.elt == param1)
            {
               if(_loc2_ == null)
               {
                  head = _loc3_.next;
               }
               else
               {
                  _loc2_.next = _loc3_.next;
               }
               break;
            }
            _loc2_ = _loc3_;
            _loc3_ = _loc3_.next;
         }
         return !(_loc3_ == null);
      }
      
      public function pop() : Object {
         var _loc1_:GenericCell_Int = head;
         if(_loc1_ == null)
         {
            return null;
         }
         head = _loc1_.next;
         return _loc1_.elt;
      }
      
      public function iterator() : Object {
         var l:GenericCell_Int = head;
         return 
            {
               "hasNext":function():Boolean
               {
                  return !(l == null);
               },
               "next":function():int
               {
                  var _loc1_:GenericCell_Int = l;
                  l = _loc1_.next;
                  return _loc1_.elt;
               }
            };
      }
      
      public function isEmpty() : Boolean {
         return head == null;
      }
      
      public var head:GenericCell_Int;
      
      public function first() : Object {
         return head == null?null:head.elt;
      }
      
      public function add(param1:int) : void {
         head = new GenericCell_Int(param1,head);
      }
   }
}
