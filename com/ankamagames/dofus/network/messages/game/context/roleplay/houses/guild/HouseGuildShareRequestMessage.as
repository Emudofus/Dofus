package com.ankamagames.dofus.network.messages.game.context.roleplay.houses.guild
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class HouseGuildShareRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function HouseGuildShareRequestMessage() {
         super();
      }
      
      public static const protocolId:uint = 5704;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var enable:Boolean = false;
      
      public var rights:uint = 0;
      
      override public function getMessageId() : uint {
         return 5704;
      }
      
      public function initHouseGuildShareRequestMessage(param1:Boolean=false, param2:uint=0) : HouseGuildShareRequestMessage {
         this.enable = param1;
         this.rights = param2;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.enable = false;
         this.rights = 0;
         this._isInitialized = false;
      }
      
      override public function pack(param1:IDataOutput) : void {
         var _loc2_:ByteArray = new ByteArray();
         this.serialize(_loc2_);
         writePacket(param1,this.getMessageId(),_loc2_);
      }
      
      override public function unpack(param1:IDataInput, param2:uint) : void {
         this.deserialize(param1);
      }
      
      public function serialize(param1:IDataOutput) : void {
         this.serializeAs_HouseGuildShareRequestMessage(param1);
      }
      
      public function serializeAs_HouseGuildShareRequestMessage(param1:IDataOutput) : void {
         param1.writeBoolean(this.enable);
         if(this.rights < 0 || this.rights > 4.294967295E9)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element rights.");
         }
         else
         {
            param1.writeUnsignedInt(this.rights);
            return;
         }
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_HouseGuildShareRequestMessage(param1);
      }
      
      public function deserializeAs_HouseGuildShareRequestMessage(param1:IDataInput) : void {
         this.enable = param1.readBoolean();
         this.rights = param1.readUnsignedInt();
         if(this.rights < 0 || this.rights > 4.294967295E9)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element of HouseGuildShareRequestMessage.rights.");
         }
         else
         {
            return;
         }
      }
   }
}
