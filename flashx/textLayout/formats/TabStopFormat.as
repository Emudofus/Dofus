package flashx.textLayout.formats
{
   import flashx.textLayout.tlf_internal;
   import flash.text.engine.TabAlignment;
   import flashx.textLayout.property.*;
   
   use namespace tlf_internal;
   
   public class TabStopFormat extends Object implements ITabStopFormat
   {
      
      public function TabStopFormat(param1:ITabStopFormat=null) {
         super();
         if(param1)
         {
            this.apply(param1);
         }
      }
      
      public static const positionProperty:Property = Property.NewNumberProperty("position",0,false,Vector.<String>([Category.TABSTOP]),0,10000);
      
      public static const alignmentProperty:Property = Property.NewEnumStringProperty("alignment",TabAlignment.START,false,Vector.<String>([Category.TABSTOP]),TabAlignment.START,TabAlignment.CENTER,TabAlignment.END,TabAlignment.DECIMAL);
      
      public static const decimalAlignmentTokenProperty:Property = Property.NewStringProperty("decimalAlignmentToken",null,false,Vector.<String>([Category.TABSTOP]));
      
      private static var _description:Object = 
         {
            "position":positionProperty,
            "alignment":alignmentProperty,
            "decimalAlignmentToken":decimalAlignmentTokenProperty
         };
      
      tlf_internal  static function get description() : Object {
         return _description;
      }
      
      private static var _emptyTabStopFormat:ITabStopFormat;
      
      tlf_internal  static function get emptyTabStopFormat() : ITabStopFormat {
         if(_emptyTabStopFormat == null)
         {
            _emptyTabStopFormat = new TabStopFormat();
         }
         return _emptyTabStopFormat;
      }
      
      public static function isEqual(param1:ITabStopFormat, param2:ITabStopFormat) : Boolean {
         if(param1 == null)
         {
            param1 = emptyTabStopFormat;
         }
         if(param2 == null)
         {
            param2 = emptyTabStopFormat;
         }
         if(param1 == param2)
         {
            return true;
         }
         if(!positionProperty.equalHelper(param1.position,param2.position))
         {
            return false;
         }
         if(!alignmentProperty.equalHelper(param1.alignment,param2.alignment))
         {
            return false;
         }
         if(!decimalAlignmentTokenProperty.equalHelper(param1.decimalAlignmentToken,param2.decimalAlignmentToken))
         {
            return false;
         }
         return true;
      }
      
      private static var _defaults:TabStopFormat;
      
      public static function get defaultFormat() : ITabStopFormat {
         if(_defaults == null)
         {
            _defaults = new TabStopFormat();
            Property.defaultsAllHelper(_description,_defaults);
         }
         return _defaults;
      }
      
      private var _position;
      
      private var _alignment;
      
      private var _decimalAlignmentToken;
      
      public function getStyle(param1:String) : * {
         return this[param1];
      }
      
      public function setStyle(param1:String, param2:*) : void {
         this[param1] = param2;
      }
      
      public function get position() : * {
         return this._position;
      }
      
      public function set position(param1:*) : void {
         this._position = positionProperty.setHelper(this._position,param1);
      }
      
      public function get alignment() : * {
         return this._alignment;
      }
      
      public function set alignment(param1:*) : void {
         this._alignment = alignmentProperty.setHelper(this._alignment,param1);
      }
      
      public function get decimalAlignmentToken() : * {
         return this._decimalAlignmentToken;
      }
      
      public function set decimalAlignmentToken(param1:*) : void {
         this._decimalAlignmentToken = decimalAlignmentTokenProperty.setHelper(this._decimalAlignmentToken,param1);
      }
      
      public function copy(param1:ITabStopFormat) : void {
         if(param1 == null)
         {
            param1 = emptyTabStopFormat;
         }
         this.position = param1.position;
         this.alignment = param1.alignment;
         this.decimalAlignmentToken = param1.decimalAlignmentToken;
      }
      
      public function concat(param1:ITabStopFormat) : void {
         this.position = positionProperty.concatHelper(this.position,param1.position);
         this.alignment = alignmentProperty.concatHelper(this.alignment,param1.alignment);
         this.decimalAlignmentToken = decimalAlignmentTokenProperty.concatHelper(this.decimalAlignmentToken,param1.decimalAlignmentToken);
      }
      
      public function concatInheritOnly(param1:ITabStopFormat) : void {
         this.position = positionProperty.concatInheritOnlyHelper(this.position,param1.position);
         this.alignment = alignmentProperty.concatInheritOnlyHelper(this.alignment,param1.alignment);
         this.decimalAlignmentToken = decimalAlignmentTokenProperty.concatInheritOnlyHelper(this.decimalAlignmentToken,param1.decimalAlignmentToken);
      }
      
      public function apply(param1:ITabStopFormat) : void {
         var _loc2_:* = undefined;
         if((_loc2_ = param1.position) !== undefined)
         {
            this.position = _loc2_;
         }
         if((_loc2_ = param1.alignment) !== undefined)
         {
            this.alignment = _loc2_;
         }
         if((_loc2_ = param1.decimalAlignmentToken) !== undefined)
         {
            this.decimalAlignmentToken = _loc2_;
         }
      }
      
      public function removeMatching(param1:ITabStopFormat) : void {
         if(param1 == null)
         {
            return;
         }
         if(positionProperty.equalHelper(this.position,param1.position))
         {
            this.position = undefined;
         }
         if(alignmentProperty.equalHelper(this.alignment,param1.alignment))
         {
            this.alignment = undefined;
         }
         if(decimalAlignmentTokenProperty.equalHelper(this.decimalAlignmentToken,param1.decimalAlignmentToken))
         {
            this.decimalAlignmentToken = undefined;
         }
      }
      
      public function removeClashing(param1:ITabStopFormat) : void {
         if(param1 == null)
         {
            return;
         }
         if(!positionProperty.equalHelper(this.position,param1.position))
         {
            this.position = undefined;
         }
         if(!alignmentProperty.equalHelper(this.alignment,param1.alignment))
         {
            this.alignment = undefined;
         }
         if(!decimalAlignmentTokenProperty.equalHelper(this.decimalAlignmentToken,param1.decimalAlignmentToken))
         {
            this.decimalAlignmentToken = undefined;
         }
      }
   }
}
