package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.dofus.network.types.game.prism.AlignmentBonusInformations;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class PrismAlignmentBonusResultMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function PrismAlignmentBonusResultMessage() {
         this.alignmentBonus=new AlignmentBonusInformations();
         super();
      }

      public static const protocolId:uint = 5842;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var alignmentBonus:AlignmentBonusInformations;

      override public function getMessageId() : uint {
         return 5842;
      }

      public function initPrismAlignmentBonusResultMessage(alignmentBonus:AlignmentBonusInformations=null) : PrismAlignmentBonusResultMessage {
         this.alignmentBonus=alignmentBonus;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.alignmentBonus=new AlignmentBonusInformations();
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
         this.serializeAs_PrismAlignmentBonusResultMessage(output);
      }

      public function serializeAs_PrismAlignmentBonusResultMessage(output:IDataOutput) : void {
         this.alignmentBonus.serializeAs_AlignmentBonusInformations(output);
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismAlignmentBonusResultMessage(input);
      }

      public function deserializeAs_PrismAlignmentBonusResultMessage(input:IDataInput) : void {
         this.alignmentBonus=new AlignmentBonusInformations();
         this.alignmentBonus.deserialize(input);
      }
   }

}