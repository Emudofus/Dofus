package com.ankamagames.dofus.datacenter.quest.treasureHunt
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.logic.game.roleplay.managers.RoleplayManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   
   public class LegendaryTreasureHunt extends Object implements IDataCenter
   {
      
      public function LegendaryTreasureHunt()
      {
         super();
      }
      
      public static const MODULE:String = "LegendaryTreasureHunts";
      
      public static function getLegendaryTreasureHuntById(param1:int) : LegendaryTreasureHunt
      {
         return GameData.getObject(MODULE,param1) as LegendaryTreasureHunt;
      }
      
      public static function getLegendaryTreasureHunts() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var level:uint;
      
      public var chestId:uint;
      
      public var monsterId:uint;
      
      public var mapItemId:uint;
      
      public var xpRatio:Number;
      
      private var _name:String;
      
      private var _monster:Monster;
      
      private var _chest:Item;
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
      
      public function get monster() : Monster
      {
         if(!this._monster)
         {
            this._monster = Monster.getMonsterById(this.monsterId);
         }
         return this._monster;
      }
      
      public function get chest() : Item
      {
         if(!this._chest)
         {
            this._chest = Item.getItemById(this.chestId);
         }
         return this._chest;
      }
      
      public function get experienceReward() : int
      {
         return RoleplayManager.getInstance().getExperienceReward(PlayedCharacterManager.getInstance().infos.level,PlayedCharacterManager.getInstance().experiencePercent,this.level,this.xpRatio);
      }
   }
}
