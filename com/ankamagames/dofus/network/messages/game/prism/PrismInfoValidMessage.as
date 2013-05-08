package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.fight.ProtectedEntityWaitingForHelpInfo;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class PrismInfoValidMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function PrismInfoValidMessage() {
         this.waitingForHelpInfo=new ProtectedEntityWaitingForHelpInfo();
         super();
      }

      public static const protocolId:uint = 5858;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo;

      override public function getMessageId() : uint {
         return 5858;
      }

      public function initPrismInfoValidMessage(waitingForHelpInfo:ProtectedEntityWaitingForHelpInfo=null) : PrismInfoValidMessage {
         this.waitingForHelpInfo=waitingForHelpInfo;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.waitingForHelpInfo=new ProtectedEntityWaitingForHelpInfo();
         this._isInitialized=false;
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
         this.serializeAs_PrismInfoValidMessage(output);
      }

      public function serializeAs_PrismInfoValidMessage(output:IDataOutput) : void {
         this.waitingForHelpInfo.serializeAs_ProtectedEntityWaitingForHelpInfo(output);
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismInfoValidMessage(input);
      }

      public function deserializeAs_PrismInfoValidMessage(input:IDataInput) : void {
         this.waitingForHelpInfo=new ProtectedEntityWaitingForHelpInfo();
         this.waitingForHelpInfo.deserialize(input);
      }
   }

}