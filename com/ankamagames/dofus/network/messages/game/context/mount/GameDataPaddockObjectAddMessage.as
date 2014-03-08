package com.ankamagames.dofus.network.messages.game.context.mount
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.paddock.PaddockItem;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class GameDataPaddockObjectAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function GameDataPaddockObjectAddMessage() {
         this.paddockItemDescription = new PaddockItem();
         super();
      }
      
      public static const protocolId:uint = 5990;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var paddockItemDescription:PaddockItem;
      
      override public function getMessageId() : uint {
         return 5990;
      }
      
      public function initGameDataPaddockObjectAddMessage(param1:PaddockItem=null) : GameDataPaddockObjectAddMessage {
         this.paddockItemDescription = param1;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.paddockItemDescription = new PaddockItem();
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
         this.serializeAs_GameDataPaddockObjectAddMessage(param1);
      }
      
      public function serializeAs_GameDataPaddockObjectAddMessage(param1:IDataOutput) : void {
         this.paddockItemDescription.serializeAs_PaddockItem(param1);
      }
      
      public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_GameDataPaddockObjectAddMessage(param1);
      }
      
      public function deserializeAs_GameDataPaddockObjectAddMessage(param1:IDataInput) : void {
         this.paddockItemDescription = new PaddockItem();
         this.paddockItemDescription.deserialize(param1);
      }
   }
}
