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
      
      public function initShowCellSpectatorMessage(param1:int=0, param2:uint=0, param3:String="") : ShowCellSpectatorMessage {
         super.initShowCellMessage(param1,param2);
         this.playerName = param3;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         super.reset();
         this.playerName = "";
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
      
      override public function serialize(param1:IDataOutput) : void {
         this.serializeAs_ShowCellSpectatorMessage(param1);
      }
      
      public function serializeAs_ShowCellSpectatorMessage(param1:IDataOutput) : void {
         super.serializeAs_ShowCellMessage(param1);
         param1.writeUTF(this.playerName);
      }
      
      override public function deserialize(param1:IDataInput) : void {
         this.deserializeAs_ShowCellSpectatorMessage(param1);
      }
      
      public function deserializeAs_ShowCellSpectatorMessage(param1:IDataInput) : void {
         super.deserialize(param1);
         this.playerName = param1.readUTF();
      }
   }
}
