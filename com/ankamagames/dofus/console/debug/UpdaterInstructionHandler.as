package com.ankamagames.dofus.console.debug
{
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.dofus.network.enums.PartStateEnum;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.dofus.console.debug.frames.UpdaterDebugFrame;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.network.types.updater.ContentPart;
   
   public class UpdaterInstructionHandler extends Object implements ConsoleInstructionHandler
   {
      
      public function UpdaterInstructionHandler() {
         super();
      }
      
      private static function stateToString(state:int) : String {
         switch(state)
         {
            case PartStateEnum.PART_BEING_UPDATER:
               return "PART_BEING_UPDATER";
            case PartStateEnum.PART_NOT_INSTALLED:
               return "PART_NOT_INSTALLED";
            case PartStateEnum.PART_UP_TO_DATE:
               return "PART_UP_TO_DATE";
            default:
               return "(unknow state)";
         }
      }
      
      private var _lastConsole:ConsoleHandler;
      
      private var _updaterDebugFrame:UpdaterDebugFrame;
      
      public function get updaterDebugFrame() : UpdaterDebugFrame {
         if(!this._updaterDebugFrame)
         {
            this._updaterDebugFrame = Kernel.getWorker().getFrame(UpdaterDebugFrame) as UpdaterDebugFrame;
            if(!this._updaterDebugFrame)
            {
               this._updaterDebugFrame = new UpdaterDebugFrame();
               Kernel.getWorker().addFrame(this._updaterDebugFrame);
            }
         }
         return this._updaterDebugFrame;
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void {
         this._lastConsole = console;
         switch(cmd)
         {
            case "partdebug":
               break;
            case "partlist":
               this.updaterDebugFrame.partListRequest(this.onPartInfo);
               break;
            case "partinfo":
               if(args.length == 1)
               {
                  this.updaterDebugFrame.partInfoRequest(args[0],this.onPartInfo);
               }
               else
               {
                  console.output("bad arguments");
               }
               break;
            case "updaterspeed":
               if(args.length == 1)
               {
                  this.updaterDebugFrame.setUpdaterSpeedRequest(args[0],this.onGetUpdaterSpeed);
               }
               else if(args.length == 0)
               {
                  this.updaterDebugFrame.getUpdaterSpeedRequest(this.onGetUpdaterSpeed);
               }
               else
               {
                  console.output("bad arguments");
               }
               
               break;
            case "downloadpart":
               if(args.length == 1)
               {
                  this.updaterDebugFrame.downloadPartRequest(args[0],this.onPartInfo);
               }
               else
               {
                  console.output("bad arguments");
               }
               break;
         }
      }
      
      public function getHelp(cmd:String) : String {
         switch(cmd)
         {
            case "partdebug":
               return "enable client part debugging tools. Must be run before any other part debug command";
            case "partlist":
               return "get client parts list";
            case "partinfo":
               return "get a client part details by part name";
            case "updaterspeed":
               return "get or set updater download speed (1 : slower, 10 : faster)";
            case "downloadpart":
               return "ask for part download by part name";
            default:
               return "No help for command \'" + cmd + "\'";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array {
         var possibilities:Array = [];
         if(0)
         {
         }
         return possibilities;
      }
      
      private function onGetUpdaterSpeed(speed:int) : void {
         this._lastConsole.output("updater download speed : " + speed);
      }
      
      private function onPartInfo(part:ContentPart) : void {
         if(part)
         {
            this._lastConsole.output(part.id + "\t\t\t" + stateToString(part.state));
         }
         else
         {
            this._lastConsole.output("part not found");
         }
      }
   }
}
