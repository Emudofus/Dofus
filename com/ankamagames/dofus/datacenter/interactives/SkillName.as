package com.ankamagames.dofus.datacenter.interactives
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   
   public class SkillName extends Object implements IDataCenter
   {
      
      public function SkillName() {
         super();
      }
      
      public static const MODULE:String = "SkillNames";
      
      public static function getSkillNameById(param1:int) : SkillName {
         return GameData.getObject(MODULE,param1) as SkillName;
      }
      
      public var id:int;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function get name() : String {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
