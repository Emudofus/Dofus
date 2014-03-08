package com.ankamagames.dofus.network.messages.game.inventory.items
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.data.items.GoldItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GoldAddedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GoldAddedMessage() {
         this.gold = new GoldItem();
         super();
      }
      
      public static const protocolId:uint = 6030;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var gold:GoldItem;
      
      override public function getMessageId() : uint {
         return 6030;
      }
      
      public function initGoldAddedMessage(gold:GoldItem=null) : GoldAddedMessage {
         this.gold = gold;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.gold = new GoldItem();
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
         this.serializeAs_GoldAddedMessage(output);
      }
      
      public function serializeAs_GoldAddedMessage(output:IDataOutput) : void {
         this.gold.serializeAs_GoldItem(output);
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_GoldAddedMessage(input);
      }
      
      public function deserializeAs_GoldAddedMessage(input:IDataInput) : void {
         this.gold = new GoldItem();
         this.gold.deserialize(input);
      }
   }
}
