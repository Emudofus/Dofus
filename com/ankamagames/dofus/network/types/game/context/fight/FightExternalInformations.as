package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.Vector;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class FightExternalInformations extends Object implements INetworkType
   {
      
      public function FightExternalInformations() {
         this.fightTeams = new Vector.<FightTeamLightInformations>(2,true);
         this.fightTeamsOptions = new Vector.<FightOptionsInformations>(2,true);
         super();
      }
      
      public static const protocolId:uint = 117;
      
      public var fightId:int = 0;
      
      public var fightType:uint = 0;
      
      public var fightStart:uint = 0;
      
      public var fightSpectatorLocked:Boolean = false;
      
      public var fightTeams:Vector.<FightTeamLightInformations>;
      
      public var fightTeamsOptions:Vector.<FightOptionsInformations>;
      
      public function getTypeId() : uint {
         return 117;
      }
      
      public function initFightExternalInformations(param1:int=0, param2:uint=0, param3:uint=0, param4:Boolean=false, param5:Vector.<FightTeamLightInformations>=null, param6:Vector.<FightOptionsInformations>=null) : FightExternalInformations {
         this.fightId = param1;
         this.fightType = param2;
         this.fightStart = param3;
         this.fightSpectatorLocked = param4;
         this.fightTeams = param5;
         this.fightTeamsOptions = param6;
         return this;
      }
      
      public function reset() : void {
         this.fightId = 0;
         this.fightType = 0;
         this.fightStart = 0;
         this.fightSpectatorLocked = false;
         this.fightTeams = new Vector.<FightTeamLightInformations>(2,true);
         this.fightTeamsOptions = new Vector.<FightOptionsInformations>(2,true);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_FightExternalInformations(param1);
      }
      
      public function serializeAs_FightExternalInformations(param1:IDataOutput) : void {
         param1.writeInt(this.fightId);
         param1.writeByte(this.fightType);
         if(this.fightStart < 0)
         {
            throw new Error("Forbidden value (" + this.fightStart + ") on element fightStart.");
         }
         else
         {
            param1.writeInt(this.fightStart);
            param1.writeBoolean(this.fightSpectatorLocked);
            _loc2_ = 0;
            while(_loc2_ < 2)
            {
               this.fightTeams[_loc2_].serializeAs_FightTeamLightInformations(param1);
               _loc2_++;
            }
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               this.fightTeamsOptions[_loc3_].serializeAs_FightOptionsInformations(param1);
               _loc3_++;
            }
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_FightExternalInformations(param1);
      }
      
      public function deserializeAs_FightExternalInformations(param1:IDataInput) : void {
         this.fightId = param1.readInt();
         this.fightType = param1.readByte();
         if(this.fightType < 0)
         {
            throw new Error("Forbidden value (" + this.fightType + ") on element of FightExternalInformations.fightType.");
         }
         else
         {
            this.fightStart = param1.readInt();
            if(this.fightStart < 0)
            {
               throw new Error("Forbidden value (" + this.fightStart + ") on element of FightExternalInformations.fightStart.");
            }
            else
            {
               this.fightSpectatorLocked = param1.readBoolean();
               _loc2_ = 0;
               while(_loc2_ < 2)
               {
                  this.fightTeams[_loc2_] = new FightTeamLightInformations();
                  this.fightTeams[_loc2_].deserialize(param1);
                  _loc2_++;
               }
               _loc3_ = 0;
               while(_loc3_ < 2)
               {
                  this.fightTeamsOptions[_loc3_] = new FightOptionsInformations();
                  this.fightTeamsOptions[_loc3_].deserialize(param1);
                  _loc3_++;
               }
               return;
            }
         }
      }
   }
}
