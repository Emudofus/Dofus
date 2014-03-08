package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class GameFightMinimalStatsPreparation extends GameFightMinimalStats implements INetworkType
   {
      
      public function GameFightMinimalStatsPreparation() {
         super();
      }
      
      public static const protocolId:uint = 360;
      
      public var initiative:uint = 0;
      
      override public function getTypeId() : uint {
         return 360;
      }
      
      public function initGameFightMinimalStatsPreparation(param1:uint=0, param2:uint=0, param3:uint=0, param4:uint=0, param5:uint=0, param6:int=0, param7:int=0, param8:int=0, param9:int=0, param10:int=0, param11:Boolean=false, param12:int=0, param13:int=0, param14:int=0, param15:int=0, param16:int=0, param17:int=0, param18:int=0, param19:int=0, param20:int=0, param21:int=0, param22:int=0, param23:int=0, param24:uint=0, param25:uint=0, param26:int=0, param27:int=0, param28:int=0, param29:uint=0) : GameFightMinimalStatsPreparation {
         super.initGameFightMinimalStats(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14,param15,param16,param17,param18,param19,param20,param21,param22,param23,param24,param25,param26,param27,param28);
         this.initiative = param29;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.initiative = 0;
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_GameFightMinimalStatsPreparation(param1);
      }
      
      public function serializeAs_GameFightMinimalStatsPreparation(param1:IDataOutput) : void {
         super.serializeAs_GameFightMinimalStats(param1);
         if(this.initiative < 0)
         {
            throw new Error("Forbidden value (" + this.initiative + ") on element initiative.");
         }
         else
         {
            param1.writeInt(this.initiative);
            return;
         }
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameFightMinimalStatsPreparation(param1);
      }
      
      public function deserializeAs_GameFightMinimalStatsPreparation(param1:IDataInput) : void {
         super.deserialize(param1);
         this.initiative = param1.readInt();
         if(this.initiative < 0)
         {
            throw new Error("Forbidden value (" + this.initiative + ") on element of GameFightMinimalStatsPreparation.initiative.");
         }
         else
         {
            return;
         }
      }
   }
}
