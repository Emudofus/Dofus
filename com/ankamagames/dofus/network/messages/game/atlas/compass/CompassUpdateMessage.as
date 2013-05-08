package com.ankamagames.dofus.network.messages.game.atlas.compass
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;


   public class CompassUpdateMessage extends NetworkMessage implements INetworkMessage
   {
         

      public function CompassUpdateMessage() {
         super();
      }

      public static const protocolId:uint = 5591;

      private var _isInitialized:Boolean = false;

      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }

      public var type:uint = 0;

      public var worldX:int = 0;

      public var worldY:int = 0;

      override public function getMessageId() : uint {
         return 5591;
      }

      public function initCompassUpdateMessage(type:uint=0, worldX:int=0, worldY:int=0) : CompassUpdateMessage {
         this.type=type;
         this.worldX=worldX;
         this.worldY=worldY;
         this._isInitialized=true;
         return this;
      }

      override public function reset() : void {
         this.type=0;
         this.worldX=0;
         this.worldY=0;
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
         this.serializeAs_CompassUpdateMessage(output);
      }

      public function serializeAs_CompassUpdateMessage(output:IDataOutput) : void {
         output.writeByte(this.type);
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
               return;
            }
         }
      }

      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_CompassUpdateMessage(input);
      }

      public function deserializeAs_CompassUpdateMessage(input:IDataInput) : void {
         this.type=input.readByte();
         if(this.type<0)
         {
            throw new Error("Forbidden value ("+this.type+") on element of CompassUpdateMessage.type.");
         }
         else
         {
            this.worldX=input.readShort();
            if((this.worldX>-255)||(this.worldX<255))
            {
               throw new Error("Forbidden value ("+this.worldX+") on element of CompassUpdateMessage.worldX.");
            }
            else
            {
               this.worldY=input.readShort();
               if((this.worldY>-255)||(this.worldY<255))
               {
                  throw new Error("Forbidden value ("+this.worldY+") on element of CompassUpdateMessage.worldY.");
               }
               else
               {
                  return;
               }
            }
         }
      }
   }

}