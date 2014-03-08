package com.ankamagames.dofus.internalDatacenter.conquest
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.dofus.network.types.game.guild.GuildEmblem;
   import com.ankamagames.dofus.internalDatacenter.guild.EmblemWrapper;
   import com.ankamagames.jerakine.data.I18n;
   
   public class AllianceOnTheHillWrapper extends Object implements IDataCenter
   {
      
      public function AllianceOnTheHillWrapper() {
         super();
      }
      
      public static function create(pAllianceId:uint, pAllianceTag:String, pAllianceName:String, pAllianceEmblem:GuildEmblem, nbMembers:uint, roundWeigth:uint, matchScore:uint, side:uint) : AllianceOnTheHillWrapper {
         var item:AllianceOnTheHillWrapper = new AllianceOnTheHillWrapper();
         item.allianceId = pAllianceId;
         item._allianceTag = pAllianceTag;
         item._allianceName = pAllianceName;
         if(pAllianceEmblem != null)
         {
            item.upEmblem = EmblemWrapper.create(pAllianceEmblem.symbolShape,EmblemWrapper.UP,pAllianceEmblem.symbolColor);
            item.backEmblem = EmblemWrapper.create(pAllianceEmblem.backgroundShape,EmblemWrapper.BACK,pAllianceEmblem.backgroundColor);
         }
         item.nbMembers = nbMembers;
         item.roundWeigth = roundWeigth;
         item.matchScore = matchScore;
         item.side = side;
         return item;
      }
      
      private var _allianceName:String;
      
      private var _allianceTag:String;
      
      public var allianceId:uint;
      
      public var upEmblem:EmblemWrapper;
      
      public var backEmblem:EmblemWrapper;
      
      public var nbMembers:uint = 0;
      
      public var roundWeigth:uint = 0;
      
      public var matchScore:uint = 0;
      
      public var side:uint = 0;
      
      public function get allianceTag() : String {
         if(this._allianceTag == "#TAG#")
         {
            return I18n.getUiText("ui.alliance.noTag");
         }
         return this._allianceTag;
      }
      
      public function get realAllianceTag() : String {
         return this._allianceTag;
      }
      
      public function get allianceName() : String {
         if(this._allianceName == "#NONAME#")
         {
            return I18n.getUiText("ui.guild.noName");
         }
         return this._allianceName;
      }
      
      public function get realAllianceName() : String {
         return this._allianceName;
      }
      
      public function update(pAllianceId:uint, pAllianceTag:String, pAllianceName:String, pAllianceEmblem:GuildEmblem, nbMembers:uint, roundWeigth:uint, matchScore:uint, side:uint) : void {
         this.allianceId = pAllianceId;
         this._allianceTag = pAllianceTag;
         this._allianceName = pAllianceName;
         this.upEmblem.update(pAllianceEmblem.symbolShape,EmblemWrapper.UP,pAllianceEmblem.symbolColor);
         this.backEmblem.update(pAllianceEmblem.backgroundShape,EmblemWrapper.BACK,pAllianceEmblem.backgroundColor);
         this.nbMembers = nbMembers;
         this.roundWeigth = roundWeigth;
         this.matchScore = matchScore;
         this.side = side;
      }
   }
}
