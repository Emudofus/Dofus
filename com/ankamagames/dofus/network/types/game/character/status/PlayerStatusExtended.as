package com.ankamagames.dofus.network.types.game.character.status
{
   import com.ankamagames.jerakine.network.INetworkType;
   import flash.utils.IDataOutput;
   import flash.utils.IDataInput;
   
   public class PlayerStatusExtended extends PlayerStatus implements INetworkType
   {
      
      public function PlayerStatusExtended() {
         super();
      }
      
      public static const protocolId:uint = 414;
      
      public var message:String = "";
      
      override public function getTypeId() : uint {
         return 414;
      }
      
      public function initPlayerStatusExtended(param1:uint=1, param2:String="") : PlayerStatusExtended {
         super.initPlayerStatus(param1);
         this.message = param2;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.message = "";
      }
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_PlayerStatusExtended(param1);
      }
      
      public function serializeAs_PlayerStatusExtended(param1:IDataOutput) : void {
         super.serializeAs_PlayerStatus(param1);
         param1.writeUTF(this.message);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_PlayerStatusExtended(param1);
      }
      
      public function deserializeAs_PlayerStatusExtended(param1:IDataInput) : void {
         super.deserialize(param1);
         this.message = param1.readUTF();
      }
   }
}
