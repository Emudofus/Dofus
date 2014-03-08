package com.ankamagames.dofus.datacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class Emoticon extends Object implements IDataCenter
   {
      
      public function Emoticon() {
         super();
      }
      
      public static const MODULE:String = "Emoticons";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Emoticon));
      
      public static function getEmoticonById(param1:int) : Emoticon {
         return GameData.getObject(MODULE,param1) as Emoticon;
      }
      
      public static function getEmoticons() : Array {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var shortcutId:uint;
      
      public var order:uint;
      
      public var defaultAnim:String;
      
      public var persistancy:Boolean;
      
      public var eight_directions:Boolean;
      
      public var aura:Boolean;
      
      public var anims:Vector.<String>;
      
      public var cooldown:uint = 1000;
      
      public var duration:uint = 0;
      
      public var weight:uint;
      
      private var _name:String;
      
      private var _shortcut:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get shortcut() : String {
         if(!this._shortcut)
         {
            this._shortcut = I18n.getText(this.shortcutId);
         }
         if(!this._shortcut || this._shortcut == "")
         {
            return this.defaultAnim;
         }
         return this._shortcut;
      }
      
      public function getAnimName(param1:TiphonEntityLook) : String {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:uint = 0;
         var _loc10_:* = undefined;
         if(param1)
         {
            for each (_loc3_ in this.anims)
            {
               _loc4_ = _loc3_.split(";");
               _loc5_ = parseInt(_loc4_[0]);
               if((param1) && _loc5_ == param1.getBone())
               {
                  _loc6_ = _loc4_[1].split(",");
                  _loc7_ = 0;
                  for each (_loc8_ in _loc6_)
                  {
                     _loc9_ = parseInt(_loc8_);
                     for each (_loc10_ in param1.skins)
                     {
                        if(_loc9_ == _loc10_)
                        {
                           _loc7_++;
                        }
                     }
                  }
                  if(_loc7_ > 0)
                  {
                     _loc2_ = "AnimEmote" + _loc4_[2];
                  }
               }
            }
         }
         if(!_loc2_)
         {
            _loc2_ = "AnimEmote" + this.defaultAnim.charAt(0).toUpperCase() + this.defaultAnim.substr(1).toLowerCase() + "_0";
         }
         return _loc2_;
      }
   }
}
