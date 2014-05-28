package com.ankamagames.dofus.datacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.logger.Log;
   import flash.utils.getQualifiedClassName;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   
   public class Emoticon extends Object implements IDataCenter
   {
      
      public function Emoticon() {
         super();
      }
      
      public static const MODULE:String = "Emoticons";
      
      protected static const _log:Logger;
      
      public static function getEmoticonById(id:int) : Emoticon {
         return GameData.getObject(MODULE,id) as Emoticon;
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
         if((!this._shortcut) || (this._shortcut == ""))
         {
            return this.defaultAnim;
         }
         return this._shortcut;
      }
      
      public function getAnimName(look:TiphonEntityLook) : String {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Error type: TranslateException
          */
         throw new IllegalOperationError("Not decompiled due to error");
      }
   }
}
