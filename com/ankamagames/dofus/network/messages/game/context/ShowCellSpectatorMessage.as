package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ShowCellSpectatorMessage extends ShowCellMessage implements INetworkMessage
   {
      
      public function ShowCellSpectatorMessage() {
         super();
      }
      
      public static const protocolId:uint = 6158;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return (super.isInitialized) && (this._isInitialized);
      }
      
      public var playerName:String = "";
      
      override public function getMessageId() : uint {
         return 6158;
      }
      
      public function initShowCellSpectatorMessage(sourceId:int=0, cellId:uint=0, playerName:String="") : ShowCellSpectatorMessage {
         super.initShowCellMessage(sourceId,cellId);
         this.playerName = playerName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.playerName = "";
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
      
      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_ShowCellSpectatorMessage(output);
      }
      
      public function serializeAs_ShowCellSpectatorMessage(output:IDataOutput) : void {
         super.serializeAs_ShowCellMessage(output);
         output.writeUTF(this.playerName);
      }
      
      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_ShowCellSpectatorMessage(input);
      }
      
      public function deserializeAs_ShowCellSpectatorMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.playerName = input.readUTF();
      }
   }
}
