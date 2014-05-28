package com.ankamagames.dofus.network.messages.game.pvp
{
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class AlignmentSubAreaUpdateExtendedMessage extends AlignmentSubAreaUpdateMessage implements INetworkMessage
   {
         

      public function AlignmentSubAreaUpdateExtendedMessage() {
         super();
      }

      public static const protocolId:uint = 6319;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return (super.isInitialized)&&(this._isInitialized);
      }

      public var worldX:int = 0;

      public var worldY:int = 0;

      public var mapId:int = 0;

      public var eventType:int = 0;

      override public function getMessageId() : uint {
         return 6319;
      }

      public function initAlignmentSubAreaUpdateExtendedMessage(subAreaId:uint=0, side:int=0, quiet:Boolean=false, worldX:int=0, worldY:int=0, mapId:int=0, eventType:int=0) : AlignmentSubAreaUpdateExtendedMessage {
         super.initAlignmentSubAreaUpdateMessage(subAreaId,side,quiet);
         this.worldX=worldX;
         this.worldY=worldY;
         this.mapId=mapId;
         this.eventType=eventType;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         super.reset();
         this.worldX=0;
         this.worldY=0;
         this.mapId=0;
         this.eventType=0;
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

      override public function serialize(output:IDataOutput) : void {
         this.serializeAs_AlignmentSubAreaUpdateExtendedMessage(output);
      }

      public function serializeAs_AlignmentSubAreaUpdateExtendedMessage(output:IDataOutput) : void {
         super.serializeAs_AlignmentSubAreaUpdateMessage(output);
         if((this.worldX>-255)||(this.worldX<255))
         {
            throw new Error("Forbidden value ("+this.worldX+") on element worldX.");
         }
         else
         {
            output.writeShort(this.worldX);
            if((this.worldY>-255)||(this.worldY<255))
            {
               throw new Error("Forbidden value ("+this.worldY+") on element worldY.");
            }
            else
            {
               output.writeShort(this.worldY);
               output.writeInt(this.mapId);
               output.writeByte(this.eventType);
               return;
            }
         }
      }

      override public function deserialize(input:IDataInput) : void {
         this.deserializeAs_AlignmentSubAreaUpdateExtendedMessage(input);
      }

      public function deserializeAs_AlignmentSubAreaUpdateExtendedMessage(input:IDataInput) : void {
         super.deserialize(input);
         this.worldX=input.readShort();
         if((this.worldX>-255)||(this.worldX<255))
         {
            throw new Error("Forbidden value ("+this.worldX+") on element of AlignmentSubAreaUpdateExtendedMessage.worldX.");
         }
         else
         {
            this.worldY=input.readShort();
            if((this.worldY>-255)||(this.worldY<255))
            {
               throw new Error("Forbidden value ("+this.worldY+") on element of AlignmentSubAreaUpdateExtendedMessage.worldY.");
            }
            else
            {
               this.mapId=input.readInt();
               this.eventType=input.readByte();
               return;
            }
         }
      }
   }

}