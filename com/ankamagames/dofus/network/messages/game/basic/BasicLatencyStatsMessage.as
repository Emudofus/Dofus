package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import flash.utils.IDataOutput;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class BasicLatencyStatsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public function BasicLatencyStatsMessage() {
         super();
      }
      
      public static const protocolId:uint = 5663;
      
      private var _isInitialized:Boolean = false;
      
      override public function get isInitialized() : Boolean {
         return this._isInitialized;
      }
      
      public var latency:uint = 0;
      
      public var sampleCount:uint = 0;
      
      public var max:uint = 0;
      
      override public function getMessageId() : uint {
         return 5663;
      }
      
      public function initBasicLatencyStatsMessage(latency:uint = 0, sampleCount:uint = 0, max:uint = 0) : BasicLatencyStatsMessage {
         this.latency = latency;
         this.sampleCount = sampleCount;
         this.max = max;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void {
         this.latency = 0;
         this.sampleCount = 0;
         this.max = 0;
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
         this.serializeAs_BasicLatencyStatsMessage(output);
      }
      
      public function serializeAs_BasicLatencyStatsMessage(output:IDataOutput) : void {
         if((this.latency < 0) || (this.latency > 65535))
         {
            throw new Error("Forbidden value (" + this.latency + ") on element latency.");
         }
         else
         {
            output.writeShort(this.latency);
            if(this.sampleCount < 0)
            {
               throw new Error("Forbidden value (" + this.sampleCount + ") on element sampleCount.");
            }
            else
            {
               output.writeShort(this.sampleCount);
               if(this.max < 0)
               {
                  throw new Error("Forbidden value (" + this.max + ") on element max.");
               }
               else
               {
                  output.writeShort(this.max);
                  return;
               }
            }
         }
      }
      
      public function deserialize(input:IDataInput) : void {
         this.deserializeAs_BasicLatencyStatsMessage(input);
      }
      
      public function deserializeAs_BasicLatencyStatsMessage(input:IDataInput) : void {
         this.latency = input.readUnsignedShort();
         if((this.latency < 0) || (this.latency > 65535))
         {
            throw new Error("Forbidden value (" + this.latency + ") on element of BasicLatencyStatsMessage.latency.");
         }
         else
         {
            this.sampleCount = input.readShort();
            if(this.sampleCount < 0)
            {
               throw new Error("Forbidden value (" + this.sampleCount + ") on element of BasicLatencyStatsMessage.sampleCount.");
            }
            else
            {
               this.max = input.readShort();
               if(this.max < 0)
               {
                  throw new Error("Forbidden value (" + this.max + ") on element of BasicLatencyStatsMessage.max.");
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
