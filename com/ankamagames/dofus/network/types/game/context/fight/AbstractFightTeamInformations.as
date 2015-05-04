package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   
   public class AbstractFightTeamInformations extends Object implements INetworkType
   {
      
      public function AbstractFightTeamInformations()
      {
         super();
      }
      
      public static const protocolId:uint = 116;
      
      public var teamId:uint = 2;
      
      public var leaderId:int = 0;
      
      public var teamSide:int = 0;
      
      public var teamTypeId:uint = 0;
      
      public var nbWaves:uint = 0;
      
      public function getTypeId() : uint
      {
         return 116;
      }
      
      public function initAbstractFightTeamInformations(param1:uint = 2, param2:int = 0, param3:int = 0, param4:uint = 0, param5:uint = 0) : AbstractFightTeamInformations
      {
         this.teamId = param1;
         this.leaderId = param2;
         this.teamSide = param3;
         this.teamTypeId = param4;
         this.nbWaves = param5;
         return this;
      }
      
      public function reset() : void
      {
         this.teamId = 2;
         this.leaderId = 0;
         this.teamSide = 0;
         this.teamTypeId = 0;
         this.nbWaves = 0;
      }
      
      public function serialize(param1:ICustomDataOutput) : void
      {
         this.serializeAs_AbstractFightTeamInformations(param1);
      }
      
      public function serializeAs_AbstractFightTeamInformations(param1:ICustomDataOutput) : void
      {
         param1.writeByte(this.teamId);
         param1.writeInt(this.leaderId);
         param1.writeByte(this.teamSide);
         param1.writeByte(this.teamTypeId);
         if(this.nbWaves < 0)
         {
            throw new Error("Forbidden value (" + this.nbWaves + ") on element nbWaves.");
         }
         else
         {
            param1.writeByte(this.nbWaves);
            return;
         }
      }
      
      public function deserialize(param1:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractFightTeamInformations(param1);
      }
      
      public function deserializeAs_AbstractFightTeamInformations(param1:ICustomDataInput) : void
      {
         this.teamId = param1.readByte();
         if(this.teamId < 0)
         {
            throw new Error("Forbidden value (" + this.teamId + ") on element of AbstractFightTeamInformations.teamId.");
         }
         else
         {
            this.leaderId = param1.readInt();
            this.teamSide = param1.readByte();
            this.teamTypeId = param1.readByte();
            if(this.teamTypeId < 0)
            {
               throw new Error("Forbidden value (" + this.teamTypeId + ") on element of AbstractFightTeamInformations.teamTypeId.");
            }
            else
            {
               this.nbWaves = param1.readByte();
               if(this.nbWaves < 0)
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
