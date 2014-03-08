package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.Secure;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.errors.IllegalOperationError;
   
   public class MapElement extends Object implements Secure
   {
      
      public function MapElement(param1:String, param2:int, param3:int, param4:String, param5:*) {
         super();
         this.x = param2;
         this.y = param3;
         this.layer = param4;
         if(!_elementRef[param5])
         {
            _elementRef[param5] = new Dictionary();
         }
         this._owner = new WeakReference(param5);
         _elementRef[param5][param1] = this;
         this._id = param1;
      }
      
      public static var _elementRef:Dictionary = new Dictionary(true);
      
      public static function getElementById(param1:String, param2:*) : MapElement {
         return _elementRef[param2]?_elementRef[param2][param1]:null;
      }
      
      public static function removeElementById(param1:String, param2:*) : void {
         if(_elementRef[param2][param1])
         {
            _elementRef[param2][param1].remove();
         }
         delete _elementRef[param2][[param1]];
      }
      
      public static function removeAllElements(param1:*) : void {
         var _loc2_:* = undefined;
         var _loc3_:MapElement = null;
         for (_loc2_ in _elementRef)
         {
            if(!param1 || _loc2_ == param1)
            {
               for each (_loc3_ in _elementRef[_loc2_])
               {
                  _loc3_.remove();
               }
            }
         }
         if(!param1)
         {
            _elementRef = new Dictionary(true);
         }
         else
         {
            _elementRef[param1] = new Dictionary(true);
         }
      }
      
      public static function getOwnerElements(param1:*) : Dictionary {
         return _elementRef[param1];
      }
      
      private var _id:String;
      
      private var _owner:WeakReference;
      
      public var x:int;
      
      public var y:int;
      
      public var layer:String;
      
      public function getObject(param1:Object) : * {
         if(param1 != SecureCenter.ACCESS_KEY)
         {
            throw new IllegalOperationError();
         }
         else
         {
            return this;
         }
      }
      
      public function get id() : String {
         return this._id;
      }
      
      public function remove() : void {
         if((this._owner.object) && (_elementRef[this._owner.object]))
         {
            delete _elementRef[this._owner.object][[this._id]];
         }
      }
   }
}
