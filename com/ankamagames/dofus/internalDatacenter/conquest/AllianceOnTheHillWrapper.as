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
      
      public static function create(param1:uint, param2:String, param3:String, param4:GuildEmblem, param5:uint, param6:uint, param7:uint, param8:uint) : AllianceOnTheHillWrapper {
         var _loc9_:AllianceOnTheHillWrapper = new AllianceOnTheHillWrapper();
         _loc9_.allianceId = param1;
         _loc9_._allianceTag = param2;
         _loc9_._allianceName = param3;
         if(param4 != null)
         {
            _loc9_.upEmblem = EmblemWrapper.create(param4.symbolShape,EmblemWrapper.UP,param4.symbolColor);
            _loc9_.backEmblem = EmblemWrapper.create(param4.backgroundShape,EmblemWrapper.BACK,param4.backgroundColor);
         }
         _loc9_.nbMembers = param5;
         _loc9_.roundWeigth = param6;
         _loc9_.matchScore = param7;
         _loc9_.side = param8;
         return _loc9_;
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
      
      public function update(param1:uint, param2:String, param3:String, param4:GuildEmblem, param5:uint, param6:uint, param7:uint, param8:uint) : void {
         this.allianceId = param1;
         this._allianceTag = param2;
         this._allianceName = param3;
         this.upEmblem.update(param4.symbolShape,EmblemWrapper.UP,param4.symbolColor);
         this.backEmblem.update(param4.backgroundShape,EmblemWrapper.BACK,param4.backgroundColor);
         this.nbMembers = param5;
         this.roundWeigth = param6;
         this.matchScore = param7;
         this.side = param8;
      }
   }
}
