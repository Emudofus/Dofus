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
      
      public function initHouseGuildShareRequestMessage(enable:Boolean=false, rights:uint=0) : HouseGuildShareRequestMessage {
         this.enable = enable;
         this.rights = rights;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.enable = false;
         this.rights = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:IDataOutput) : void {
         var data:ByteArray = new ByteArray();
         this.serialize(data);
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:IDataInput, length:uint) : void {
         this.deserialize(input);
      }
      
      public function serialize(output:IDataOutput) : void {
         this.serializeAs_HouseGuildShareRequestMessage(output);
      }
      
      public function serializeAs_HouseGuildShareRequestMessage(output:IDataOutput) : void {
         output.writeBoolean(this.enable);
         if((this.rights < 0) || (this.rights > 4.294967295E9))
         {
            throw new Error("Forbidden value (" + this.rights + ") on element rights.");
         }
         else
         {
            output.writeUnsignedInt(this.rights);
            return;
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_HouseGuildShareRequestMessage(input);
      }
      
      public function deserializeAs_HouseGuildShareRequestMessage(input:IDataInput) : void {
         this.enable = input.readBoolean();
         this.rights = input.readUnsignedInt();
         if((this.rights < 0) || (this.rights > 4.294967295E9))
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
