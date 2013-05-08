package com.ankamagames.dofus.datacenter.effects
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;


   public class Effect extends Object implements IDataCenter
   {
         

      public function Effect() {
         super();
      }

      public static const MODULE:String = "Effects";

      public static function getEffectById(id:uint) : Effect {
         return GameData.getObject(MODULE,id) as Effect;
      }

      public var id:int;

      public var descriptionId:uint;

      public var iconId:uint;

      public var characteristic:int;

      public var category:uint;

      public var operator:String;

      public var showInTooltip:Boolean;

      public var useDice:Boolean;

      public var forceMinMax:Boolean;

      public var boost:Boolean;

      public var active:Boolean;

      public var showInSet:Boolean;

      public var bonusType:int;

      public var useInFight:Boolean;

      public var effectPriority:uint;

      private var _description:String;

      public function get description() : String {
         if(!this._description)
         {
            this._description=I18n.getText(this.descriptionId);
         }
         return this._description;
      }
   }

}