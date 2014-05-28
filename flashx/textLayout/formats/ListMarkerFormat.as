package flashx.textLayout.formats
{
   import flashx.textLayout.tlf_internal;
   import flashx.textLayout.property.Property;
   import __AS3__.vec.Vector;
   import flashx.textLayout.property.EnumPropertyHandler;
   import flashx.textLayout.property.CounterPropHandler;
   import flashx.textLayout.property.CounterContentHandler;
   
   use namespace tlf_internal;
   
   public class ListMarkerFormat extends TextLayoutFormat implements IListMarkerFormat
   {
      
      public function ListMarkerFormat(param1:IListMarkerFormat=null) {
         super(param1);
      }
      
      tlf_internal  static function createCounterResetProperty(param1:String, param2:String, param3:Boolean, param4:Vector.<String>) : Property {
         var _loc5_:Property = new Property(param1,param2,param3,param4);
         _loc5_.addHandlers(Property.sharedUndefinedHandler,new EnumPropertyHandler([FormatValue.NONE]),new CounterPropHandler(0));
         return _loc5_;
      }
      
      tlf_internal  static function createCounterIncrementProperty(param1:String, param2:String, param3:Boolean, param4:Vector.<String>) : Property {
         var _loc5_:Property = new Property(param1,param2,param3,param4);
         _loc5_.addHandlers(Property.sharedUndefinedHandler,new EnumPropertyHandler([FormatValue.NONE]),new CounterPropHandler(1));
         return _loc5_;
      }
      
      tlf_internal  static function createCounterContentProperty(param1:String, param2:String, param3:Boolean, param4:Vector.<String>) : Property {
         var _loc5_:Property = new Property(param1,param2,param3,param4);
         _loc5_.addHandlers(Property.sharedUndefinedHandler,new EnumPropertyHandler([FormatValue.NONE]),new CounterContentHandler());
         return _loc5_;
      }
      
      tlf_internal  static const counterResetProperty:Property = createCounterResetProperty("counterReset",FormatValue.NONE,false,Vector.<String>([Category.LIST]));
      
      tlf_internal  static const counterIncrementProperty:Property = createCounterResetProperty("counterIncrement","ordered 1",false,Vector.<String>([Category.LIST]));
      
      tlf_internal  static const beforeContentProperty:Property = Property.NewStringProperty("beforeContent",null,false,Vector.<String>([Category.LIST]));
      
      tlf_internal  static const contentProperty:Property = createCounterContentProperty("content","counter(ordered)",false,Vector.<String>([Category.LIST]));
      
      tlf_internal  static const afterContentProperty:Property = Property.NewStringProperty("afterContent",null,false,Vector.<String>([Category.LIST]));
      
      tlf_internal  static const suffixProperty:Property = Property.NewEnumStringProperty("suffix",Suffix.AUTO,false,Vector.<String>([Category.LIST]),Suffix.AUTO,Suffix.NONE);
      
      private static var _lmfDescription:Object = 
         {
            "counterReset":counterResetProperty,
            "counterIncrement":counterIncrementProperty,
            "beforeContent":beforeContentProperty,
            "content":contentProperty,
            "afterContent":afterContentProperty,
            "suffix":suffixProperty
         };
      
      private static var _description:Object;
      
      tlf_internal  static function get description() : Object {
         var _loc1_:String = null;
         if(!_description)
         {
            _description = Property.createObjectWithPrototype(TextLayoutFormat.description);
            for (_loc1_ in _lmfDescription)
            {
               _description[_loc1_] = _lmfDescription[_loc1_];
            }
         }
         return _description;
      }
      
      public static function createListMarkerFormat(param1:Object) : ListMarkerFormat {
         var _loc4_:String = null;
         var _loc2_:IListMarkerFormat = param1 as IListMarkerFormat;
         var _loc3_:ListMarkerFormat = new ListMarkerFormat(_loc2_);
         if(_loc2_ == null && (param1))
         {
            for (_loc4_ in param1)
            {
               _loc3_.setStyle(_loc4_,param1[_loc4_]);
            }
         }
         return _loc3_;
      }
      
      private function setLMFStyle(param1:Property, param2:*) : void {
         var _loc3_:String = param1.name;
         var param2:* = param1.setHelper(getStyle(_loc3_),param2);
         super.setStyleByName(_loc3_,param2);
      }
      
      override public function setStyle(param1:String, param2:*) : void {
         var _loc3_:Property = _lmfDescription[param1];
         if(_loc3_)
         {
            this.setLMFStyle(_loc3_,param2);
         }
         else
         {
            super.setStyle(param1,param2);
         }
      }
      
      public function get counterReset() : * {
         return getStyle(counterResetProperty.name);
      }
      
      public function set counterReset(param1:*) : * {
         this.setLMFStyle(counterResetProperty,param1);
      }
      
      public function get counterIncrement() : * {
         return getStyle(counterIncrementProperty.name);
      }
      
      public function set counterIncrement(param1:*) : * {
         this.setLMFStyle(counterIncrementProperty,param1);
      }
      
      public function get content() : * {
         return getStyle(contentProperty.name);
      }
      
      public function set content(param1:*) : * {
         this.setLMFStyle(contentProperty,param1);
      }
      
      public function get beforeContent() : * {
         return getStyle(beforeContentProperty.name);
      }
      
      public function set beforeContent(param1:*) : void {
         this.setLMFStyle(beforeContentProperty,param1);
      }
      
      public function get afterContent() : * {
         return getStyle(afterContentProperty.name);
      }
      
      public function set afterContent(param1:*) : void {
         this.setLMFStyle(afterContentProperty,param1);
      }
      
      public function get suffix() : * {
         return getStyle(suffixProperty.name);
      }
      
      public function set suffix(param1:*) : void {
         this.setLMFStyle(suffixProperty,param1);
      }
      
      override public function copy(param1:ITextLayoutFormat) : void {
         var _loc3_:String = null;
         super.copy(param1);
         var _loc2_:IListMarkerFormat = param1 as IListMarkerFormat;
         if(_loc2_)
         {
            for (_loc3_ in _lmfDescription)
            {
               this[_loc3_] = _loc2_[_loc3_];
            }
         }
      }
      
      override public function concat(param1:ITextLayoutFormat) : void {
         var _loc3_:Property = null;
         var _loc4_:String = null;
         super.concat(param1);
         var _loc2_:IListMarkerFormat = param1 as IListMarkerFormat;
         if(_loc2_)
         {
            for each (_loc3_ in _lmfDescription)
            {
               _loc4_ = _loc3_.name;
               this.setLMFStyle(_loc3_,_loc3_.concatHelper(this[_loc4_],_loc2_[_loc4_]));
            }
         }
      }
      
      override public function concatInheritOnly(param1:ITextLayoutFormat) : void {
         var _loc3_:Property = null;
         var _loc4_:String = null;
         super.concatInheritOnly(param1);
         var _loc2_:IListMarkerFormat = param1 as IListMarkerFormat;
         if(_loc2_)
         {
            for each (_loc3_ in _lmfDescription)
            {
               _loc4_ = _loc3_.name;
               this.setLMFStyle(_loc3_,_loc3_.concatInheritOnlyHelper(this[_loc4_],_loc2_[_loc4_]));
            }
         }
      }
      
      override public function apply(param1:ITextLayoutFormat) : void {
         var _loc3_:Property = null;
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         super.apply(param1);
         var _loc2_:IListMarkerFormat = param1 as IListMarkerFormat;
         if(_loc2_)
         {
            for each (_loc3_ in _lmfDescription)
            {
               _loc4_ = _loc3_.name;
               _loc5_ = _loc2_[_loc4_];
               if(_loc5_ !== undefined)
               {
                  this[_loc4_] = _loc5_;
               }
            }
         }
      }
      
      override public function removeMatching(param1:ITextLayoutFormat) : void {
         var _loc3_:Property = null;
         var _loc4_:String = null;
         super.removeMatching(param1);
         var _loc2_:IListMarkerFormat = param1 as IListMarkerFormat;
         if(_loc2_)
         {
            for each (_loc3_ in _lmfDescription)
            {
               _loc4_ = _loc3_.name;
               if(_loc3_.equalHelper(this[_loc4_],_loc2_[_loc4_]))
               {
                  this[_loc4_] = undefined;
               }
            }
         }
      }
      
      override public function removeClashing(param1:ITextLayoutFormat) : void {
         var _loc3_:Property = null;
         var _loc4_:String = null;
         super.removeClashing(param1);
         var _loc2_:IListMarkerFormat = param1 as IListMarkerFormat;
         if(_loc2_)
         {
            for each (_loc3_ in _lmfDescription)
            {
               _loc4_ = _loc3_.name;
               if(!_loc3_.equalHelper(this[_loc4_],_loc2_[_loc4_]))
               {
                  this[_loc4_] = undefined;
               }
            }
         }
      }
   }
}
