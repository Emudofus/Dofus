package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class PrismFightAttackedMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function PrismFightAttackedMessage() {
         super();
      }

      public static const protocolId:uint = 5894;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var worldX:int = 0;

      public var worldY:int = 0;

      public var mapId:int = 0;

      public var subAreaId:uint = 0;

      public var prismSide:int = 0;

      override public function getMessageId() : uint {
         return 5894;
      }

      public function initPrismFightAttackedMessage(worldX:int=0, worldY:int=0, mapId:int=0, subAreaId:uint=0, prismSide:int=0) : PrismFightAttackedMessage {
         this.worldX=worldX;
         this.worldY=worldY;
         this.mapId=mapId;
         this.subAreaId=subAreaId;
         this.prismSide=prismSide;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.worldX=0;
         this.worldY=0;
         this.mapId=0;
         this.subAreaId=0;
         this.prismSide=0;
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
         this.serializeAs_PrismFightAttackedMessage(output);
      }

      public function serializeAs_PrismFightAttackedMessage(output:IDataOutput) : void {
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
               if(this.subAreaId<0)
               {
                  throw new Error("Forbidden value ("+this.subAreaId+") on element subAreaId.");
               }
               else
               {
                  output.writeShort(this.subAreaId);
                  output.writeByte(this.prismSide);
                  return;
               }
            }
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_PrismFightAttackedMessage(input);
      }

      public function deserializeAs_PrismFightAttackedMessage(input:IDataInput) : void {
         this.worldX=input.readShort();
         if((this.worldX>-255)||(this.worldX<255))
         {
            throw new Error("Forbidden value ("+this.worldX+") on element of PrismFightAttackedMessage.worldX.");
         }
         else
         {
            this.worldY=input.readShort();
            if((this.worldY>-255)||(this.worldY<255))
            {
               throw new Error("Forbidden value ("+this.worldY+") on element of PrismFightAttackedMessage.worldY.");
            }
            else
            {
               this.mapId=input.readInt();
               this.subAreaId=input.readShort();
               if(this.subAreaId<0)
               {
                  throw new Error("Forbidden value ("+this.subAreaId+") on element of PrismFightAttackedMessage.subAreaId.");
               }
               else
               {
                  this.prismSide=input.readByte();
                  return;
               }
            }
         }
      }
   }

}