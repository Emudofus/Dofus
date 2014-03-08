package com.ankamagames.berilia.types.shortcut
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.berilia.managers.BindsManager;
   import flash.utils.Dictionary;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   
   public class Shortcut extends Object implements IDataCenter
   {
      
      public function Shortcut(param1:String, param2:Boolean=false, param3:String=null, param4:ShortcutCategory=null, param5:Boolean=true, param6:Boolean=true, param7:Boolean=false, param8:Boolean=false, param9:String=null) {
         super();
         if(_shortcuts[param1])
         {
            throw new BeriliaError("Shortcut name [" + param1 + "] is already use");
         }
         else
         {
            _shortcuts[param1] = this;
            this._name = param1;
            this._description = param3;
            this._textfieldEnabled = param2;
            this._category = param4;
            this._unicID = _idCount++;
            this._bindable = param5;
            this._visible = param6;
            this._required = param7;
            this._holdKeys = param8;
            this._tooltipContent = param9;
            this._disable = false;
            BindsManager.getInstance().newShortcut(this);
            return;
         }
      }
      
      private static var _shortcuts:Array = new Array();
      
      private static var _idCount:uint = 0;
      
      private static var _datastoreType:DataStoreType = new DataStoreType("Module_Ankama_Config",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
      
      public static function reset() : void {
         BindsManager.destroy();
         _shortcuts = [];
         _idCount = 0;
      }
      
      public static function loadSavedData() : void {
         var _loc2_:Shortcut = null;
         var _loc3_:Dictionary = null;
         var _loc4_:Shortcut = null;
         var _loc5_:Array = null;
         var _loc6_:String = null;
         var _loc7_:uint = 0;
         var _loc8_:* = 0;
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = false;
         var _loc1_:Object = StoreDataManager.getInstance().getData(_datastoreType,"openShortcutsCategory");
         if(_loc1_)
         {
            if(_loc1_ is Array)
            {
               _loc3_ = new Dictionary();
               _loc5_ = new Array();
               for each (_loc4_ in _shortcuts)
               {
                  if(_loc4_.visible)
                  {
                     _loc5_.push(_loc4_);
                  }
               }
               _loc5_.sortOn("unicID",Array.NUMERIC);
               _loc7_ = 0;
               _loc8_ = _loc5_.length;
               _loc9_ = _loc1_ as Array;
               _loc10_ = new Array();
               _loc7_ = 0;
               while(_loc7_ < _loc8_)
               {
                  _loc4_ = _loc5_[_loc7_];
                  if(_loc4_.category.name != _loc6_)
                  {
                     _loc12_ = _loc10_.indexOf(_loc4_.category.name);
                     if(_loc12_ == -1)
                     {
                        _loc10_.push(_loc4_.category.name);
                        _loc10_.push(_loc4_);
                        _loc6_ = _loc4_.category.name;
                     }
                     else
                     {
                        _loc13_ = 0;
                        _loc14_ = _loc12_;
                        _loc15_ = _loc10_.length;
                        while(++_loc14_ < _loc15_)
                        {
                           if(!(_loc10_[_loc14_] is String))
                           {
                              _loc13_++;
                              continue;
                           }
                           break;
                        }
                        _loc10_.splice(_loc12_ + _loc13_ + 1,0,_loc4_);
                     }
                  }
                  else
                  {
                     _loc10_.push(_loc4_);
                  }
                  _loc7_++;
               }
               _loc11_ = _loc10_.length;
               _loc7_ = 0;
               while(_loc7_ < _loc11_)
               {
                  if(_loc10_[_loc7_] is String)
                  {
                     if(_loc9_[_loc7_] != undefined)
                     {
                        _loc3_[_loc10_[_loc7_]] = _loc9_[_loc7_];
                     }
                     else
                     {
                        _loc3_[_loc10_[_loc7_]] = true;
                     }
                  }
                  _loc7_++;
               }
               _loc1_ = _loc3_;
               StoreDataManager.getInstance().setData(_datastoreType,"openShortcutsCategory",_loc1_);
            }
            for each (_loc2_ in _shortcuts)
            {
               if(_loc2_.visible)
               {
                  if(_loc1_[_loc2_.category.name] != undefined)
                  {
                     _loc16_ = !_loc1_[_loc2_.category.name];
                  }
                  else
                  {
                     _loc1_[_loc2_.category.name] = true;
                     _loc16_ = false;
                  }
                  _loc2_.disable = _loc16_;
               }
            }
         }
      }
      
      public static function getShortcutByName(param1:String) : Shortcut {
         return _shortcuts[param1];
      }
      
      public static function getShortcuts() : Array {
         return _shortcuts;
      }
      
      private var _name:String;
      
      private var _description:String;
      
      private var _tooltipContent:String;
      
      private var _textfieldEnabled:Boolean;
      
      private var _bindable:Boolean;
      
      private var _category:ShortcutCategory;
      
      private var _unicID:uint = 0;
      
      private var _visible:Boolean;
      
      private var _disable:Boolean;
      
      private var _required:Boolean;
      
      private var _holdKeys:Boolean;
      
      public var defaultBind:Bind;
      
      public function get unicID() : uint {
         return this._unicID;
      }
      
      public function get name() : String {
         return this._name;
      }
      
      public function get description() : String {
         return this._description;
      }
      
      public function get tooltipContent() : String {
         return this._tooltipContent;
      }
      
      public function get textfieldEnabled() : Boolean {
         return this._textfieldEnabled;
      }
      
      public function get bindable() : Boolean {
         return this._bindable;
      }
      
      public function get category() : ShortcutCategory {
         return this._category;
      }
      
      public function get visible() : Boolean {
         return this._visible;
      }
      
      public function set visible(param1:Boolean) : void {
         this._visible = param1;
      }
      
      public function get required() : Boolean {
         return this._required;
      }
      
      public function get holdKeys() : Boolean {
         return this._holdKeys;
      }
      
      public function get disable() : Boolean {
         return this._disable;
      }
      
      public function set disable(param1:Boolean) : void {
         this._disable = param1;
      }
   }
}
