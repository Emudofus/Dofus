package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import __AS3__.vec.*;
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
      
      public function initFightExternalInformations(fightId:int=0, fightType:uint=0, fightStart:uint=0, fightSpectatorLocked:Boolean=false, fightTeams:Vector.<FightTeamLightInformations>=null, fightTeamsOptions:Vector.<FightOptionsInformations>=null) : FightExternalInformations {
         this.fightId = fightId;
         this.fightType = fightType;
         this.fightStart = fightStart;
         this.fightSpectatorLocked = fightSpectatorLocked;
         this.fightTeams = fightTeams;
         this.fightTeamsOptions = fightTeamsOptions;
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
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_FightExternalInformations(output);
      }
      
      public function serializeAs_FightExternalInformations(output:IDataOutput) : void {
         output.writeInt(this.fightId);
         output.writeByte(this.fightType);
         if(this.fightStart < 0)
         {
            throw new Error("Forbidden value (" + this.fightStart + ") on element fightStart.");
         }
         else
         {
            output.writeInt(this.fightStart);
            output.writeBoolean(this.fightSpectatorLocked);
            _i5 = 0;
            while(_i5 < 2)
            {
               this.fightTeams[_i5].serializeAs_FightTeamLightInformations(output);
               _i5++;
            }
            _i6 = 0;
            while(_i6 < 2)
            {
               this.fightTeamsOptions[_i6].serializeAs_FightOptionsInformations(output);
               _i6++;
            }
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_FightExternalInformations(input);
      }
      
      public function deserializeAs_FightExternalInformations(input:IDataInput) : void {
         this.fightId = input.readInt();
         this.fightType = input.readByte();
         if(this.fightType < 0)
         {
            throw new Error("Forbidden value (" + this.fightType + ") on element of FightExternalInformations.fightType.");
         }
         else
         {
            this.fightStart = input.readInt();
            if(this.fightStart < 0)
            {
               throw new Error("Forbidden value (" + this.fightStart + ") on element of FightExternalInformations.fightStart.");
            }
            else
            {
               this.fightSpectatorLocked = input.readBoolean();
               _i5 = 0;
               while(_i5 < 2)
               {
                  this.fightTeams[_i5] = new FightTeamLightInformations();
                  this.fightTeams[_i5].deserialize(input);
                  _i5++;
               }
               _i6 = 0;
               while(_i6 < 2)
               {
                  this.fightTeamsOptions[_i6] = new FightOptionsInformations();
                  this.fightTeamsOptions[_i6].deserialize(input);
                  _i6++;
               }
               return;
            }
         }
      }
   }
}
