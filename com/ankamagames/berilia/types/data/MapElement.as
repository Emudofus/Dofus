package com.ankamagames.berilia.types.data
{
   import com.ankamagames.jerakine.interfaces.Secure;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.berilia.managers.SecureCenter;
   import flash.errors.IllegalOperationError;
   
   public class MapElement extends Object implements Secure
   {
      
      public function MapElement(id:String, x:int, y:int, layer:String, owner:*) {
         super();
         this.x = x;
         this.y = y;
         this.layer = layer;
         if(!_elementRef[owner])
         {
            _elementRef[owner] = new Dictionary();
         }
         this._owner = new WeakReference(owner);
         _elementRef[owner][id] = this;
         this._id = id;
      }
      
      public static var _elementRef:Dictionary;
      
      public static function getElementById(id:String, owner:*) : MapElement {
         return _elementRef[owner]?_elementRef[owner][id]:null;
      }
      
      public static function removeElementById(id:String, owner:*) : void {
         if(_elementRef[owner][id])
         {
            _elementRef[owner][id].remove();
         }
         delete _elementRef[owner][id];
      }
      
      public static function removeAllElements(owner:*) : void {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
      
      public static function getOwnerElements(owner:*) : Dictionary {
         return _elementRef[owner];
      }
      
      private var _id:String;
      
      private var _owner:WeakReference;
      
      public var x:int;
      
      public var y:int;
      
      public var layer:String;
      
      public function getObject(accessKey:Object) : * {
         if(accessKey != SecureCenter.ACCESS_KEY)
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
            delete _elementRef[this._owner.object][this._id];
         }
      }
   }
}
