package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class AbstractFightTeamInformations extends Object implements INetworkType
   {
      
      public function AbstractFightTeamInformations() {
         super();
      }
      
      public static const protocolId:uint = 116;
      
      public var teamId:uint = 2;
      
      public var leaderId:int = 0;
      
      public var teamSide:int = 0;
      
      public var teamTypeId:uint = 0;
      
      public var nbWaves:uint = 0;
      
      public function getTypeId() : uint {
         return 116;
      }
      
      public function initAbstractFightTeamInformations(teamId:uint=2, leaderId:int=0, teamSide:int=0, teamTypeId:uint=0, nbWaves:uint=0) : AbstractFightTeamInformations {
         this.teamId = teamId;
         this.leaderId = leaderId;
         this.teamSide = teamSide;
         this.teamTypeId = teamTypeId;
         this.nbWaves = nbWaves;
         return this;
      }
      
      public function reset() : void {
         this.teamId = 2;
         this.leaderId = 0;
         this.teamSide = 0;
         this.teamTypeId = 0;
         this.nbWaves = 0;
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_AbstractFightTeamInformations(output);
      }
      
      public function serializeAs_AbstractFightTeamInformations(output:IDataOutput) : void {
         output.writeByte(this.teamId);
         output.writeInt(this.leaderId);
         output.writeByte(this.teamSide);
         output.writeByte(this.teamTypeId);
         if((this.nbWaves < 0) || (this.nbWaves > 4.294967295E9))
         {
            throw new Error("Forbidden value (" + this.nbWaves + ") on element nbWaves.");
         }
         else
         {
            output.writeUnsignedInt(this.nbWaves);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AbstractFightTeamInformations(input);
      }
      
      public function deserializeAs_AbstractFightTeamInformations(input:IDataInput) : void {
         this.teamId = input.readByte();
         if(this.teamId < 0)
         {
            throw new Error("Forbidden value (" + this.teamId + ") on element of AbstractFightTeamInformations.teamId.");
         }
         else
         {
            this.leaderId = input.readInt();
            this.teamSide = input.readByte();
            this.teamTypeId = input.readByte();
            if(this.teamTypeId < 0)
            {
               throw new Error("Forbidden value (" + this.teamTypeId + ") on element of AbstractFightTeamInformations.teamTypeId.");
            }
            else
            {
               this.nbWaves = input.readUnsignedInt();
               if((this.nbWaves < 0) || (this.nbWaves > 4.294967295E9))
               {
                  throw new Error("Forbidden value (" + this.nbWaves + ") on element of AbstractFightTeamInformations.nbWaves.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }
}
