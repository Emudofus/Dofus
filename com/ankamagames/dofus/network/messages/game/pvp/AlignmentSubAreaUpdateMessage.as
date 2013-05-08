package com.ankamagames.dofus.network.messages.game.pvp
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class AlignmentSubAreaUpdateMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function AlignmentSubAreaUpdateMessage() {
         super();
      }

      public static const protocolId:uint = 6057;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var subAreaId:uint = 0;

      public var side:int = 0;

      public var quiet:Boolean = false;

      override public function getMessageId() : uint {
         return 6057;
      }

      public function initAlignmentSubAreaUpdateMessage(subAreaId:uint=0, side:int=0, quiet:Boolean=false) : AlignmentSubAreaUpdateMessage {
         this.subAreaId=subAreaId;
         this.side=side;
         this.quiet=quiet;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.subAreaId=0;
         this.side=0;
         this.quiet=false;
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
         this.serializeAs_AlignmentSubAreaUpdateMessage(output);
      }

      public function serializeAs_AlignmentSubAreaUpdateMessage(output:IDataOutput) : void {
         if(this.subAreaId<0)
         {
            throw new Error("Forbidden value ("+this.subAreaId+") on element subAreaId.");
         }
         else
         {
            output.writeShort(this.subAreaId);
            output.writeByte(this.side);
            output.writeBoolean(this.quiet);
            return;
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AlignmentSubAreaUpdateMessage(input);
      }

      public function deserializeAs_AlignmentSubAreaUpdateMessage(input:IDataInput) : void {
         this.subAreaId=input.readShort();
         if(this.subAreaId<0)
         {
            throw new Error("Forbidden value ("+this.subAreaId+") on element of AlignmentSubAreaUpdateMessage.subAreaId.");
         }
         else
         {
            this.side=input.readByte();
            this.quiet=input.readBoolean();
            return;
         }
      }
   }

}