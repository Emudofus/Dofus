package com.ankamagames.dofus.logic.game.roleplay.types
{
   import flash.utils.Dictionary;
   import __AS3__.vec.Vector;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.dofus.datacenter.monsters.Companion;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberInformations;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberCompanionInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberWithAllianceCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.FightTeamMemberTaxCollectorInformations;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorFirstname;
   import com.ankamagames.dofus.datacenter.npcs.TaxCollectorName;
   
   public class RoleplayTeamFightersTooltipInformation extends Object
   {
      
      public function RoleplayTeamFightersTooltipInformation(param1:FightTeam) {
         var _loc2_:FightTeamMemberInformations = null;
         var _loc3_:* = 0;
         var _loc5_:Fighter = null;
         var _loc6_:String = null;
         var _loc7_:Monster = null;
         var _loc8_:uint = 0;
         var _loc9_:String = null;
         var _loc10_:uint = 0;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:FightTeamMemberCompanionInformations = null;
         super();
         this.fighters = new Vector.<Fighter>();
         var _loc4_:int = param1.teamInfos.teamMembers.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = param1.teamInfos.teamMembers[_loc3_];
            _loc5_ = null;
            switch(true)
            {
               case _loc2_ is FightTeamMemberCharacterInformations:
                  if(_loc2_ is FightTeamMemberWithAllianceCharacterInformations)
                  {
                     _loc6_ = (_loc2_ as FightTeamMemberWithAllianceCharacterInformations).allianceInfos.allianceTag;
                  }
                  _loc5_ = new Fighter(_loc2_.id,(_loc2_ as FightTeamMemberCharacterInformations).name,(_loc2_ as FightTeamMemberCharacterInformations).level,_loc6_);
                  break;
               case _loc2_ is FightTeamMemberMonsterInformations:
                  _loc7_ = Monster.getMonsterById((_loc2_ as FightTeamMemberMonsterInformations).monsterId);
                  _loc8_ = _loc7_.getMonsterGrade((_loc2_ as FightTeamMemberMonsterInformations).grade).level;
                  _loc9_ = _loc7_.name;
                  _loc5_ = new Fighter(_loc2_.id,_loc9_,_loc8_);
                  break;
               case _loc2_ is FightTeamMemberTaxCollectorInformations:
                  _loc10_ = (_loc2_ as FightTeamMemberTaxCollectorInformations).level;
                  _loc11_ = TaxCollectorFirstname.getTaxCollectorFirstnameById((_loc2_ as FightTeamMemberTaxCollectorInformations).firstNameId).firstname;
                  _loc12_ = TaxCollectorName.getTaxCollectorNameById((_loc2_ as FightTeamMemberTaxCollectorInformations).lastNameId).name;
                  _loc13_ = _loc11_ + " " + _loc12_;
                  _loc5_ = new Fighter(_loc2_.id,_loc13_,_loc10_);
                  break;
               case _loc2_ is FightTeamMemberCompanionInformations:
                  _loc14_ = _loc2_ as FightTeamMemberCompanionInformations;
                  if(this.fighters.length > 0 && _loc3_ > 0 && this.fighters[_loc3_-1].id == _loc14_.masterId)
                  {
                     _loc5_ = this.getCompanionFighter(this.fighters[_loc3_-1],_loc14_.id,_loc14_.companionId);
                  }
                  else
                  {
                     if(!this._waitingCompanions)
                     {
                        this._waitingCompanions = new Dictionary();
                     }
                     this._waitingCompanions[_loc14_.masterId] = 
                        {
                           "id":_loc14_.id,
                           "genericId":_loc14_.companionId
                        };
                  }
                  break;
            }
            if(_loc5_)
            {
               this.fighters.push(_loc5_);
               if((this._waitingCompanions) && (this._waitingCompanions[_loc5_.id]))
               {
                  this.fighters.push(this.getCompanionFighter(_loc5_,this._waitingCompanions[_loc5_.id].id,this._waitingCompanions[_loc5_.id].genericId));
                  delete this._waitingCompanions[[_loc5_.id]];
               }
            }
            _loc3_++;
         }
      }
      
      private var _waitingCompanions:Dictionary;
      
      public var fighters:Vector.<Fighter>;
      
      private function getCompanionFighter(param1:Fighter, param2:int, param3:int) : Fighter {
         return new Fighter(param2,I18n.getUiText("ui.common.belonging",[Companion.getCompanionById(param3).name,param1.name]),param1.level,param1.allianceTagName);
      }
   }
}
class Fighter extends Object
{
   
   function Fighter(param1:int, param2:String, param3:uint, param4:String=null) {
      super();
      this._id = param1;
      this.name = param2;
      this.level = param3;
      this.allianceTagName = param4;
   }
   
   private var _id:int;
   
   public var allianceTagName:String;
   
   public var name:String;
   
   public var level:uint;
   
   public function get allianceTag() : String {
      return this.allianceTagName?"[" + this.allianceTagName + "]":null;
   }
   
   public function get id() : int {
      return this._id;
   }
}
