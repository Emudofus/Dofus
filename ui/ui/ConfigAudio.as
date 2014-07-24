package ui
{
   import d2api.DataApi;
   import d2api.SoundApi;
   import d2components.ButtonContainer;
   import d2components.GraphicContainer;
   import d2components.TextArea;
   import flash.utils.Dictionary;
   import types.ConfigProperty;
   import d2hooks.*;
   import d2actions.*;
   import com.ankamagames.dofusModuleLibrary.enum.SoundEnum;
   import flash.events.Event;
   
   public class ConfigAudio extends ConfigUi
   {
      
      public function ConfigAudio() {
         super();
      }
      
      public var output:Object;
      
      public var dataApi:DataApi;
      
      public var soundApi:SoundApi;
      
      public var modCommon:Object;
      
      public var btn_activateSounds:ButtonContainer;
      
      public var btn_playSoundForGuildMessage:ButtonContainer;
      
      public var btn_playSoundAtTurnStart:ButtonContainer;
      
      public var btn_infiniteLoopMusics:ButtonContainer;
      
      public var btn_musicVolume1:ButtonContainer;
      
      public var btn_musicVolume2:ButtonContainer;
      
      public var btn_musicVolume3:ButtonContainer;
      
      public var btn_musicVolume4:ButtonContainer;
      
      public var btn_musicVolume5:ButtonContainer;
      
      public var btn_musicMute:ButtonContainer;
      
      public var btn_soundVolume1:ButtonContainer;
      
      public var btn_soundVolume2:ButtonContainer;
      
      public var btn_soundVolume3:ButtonContainer;
      
      public var btn_soundVolume4:ButtonContainer;
      
      public var btn_soundVolume5:ButtonContainer;
      
      public var btn_soundMute:ButtonContainer;
      
      public var btn_ambientSoundVolume1:ButtonContainer;
      
      public var btn_ambientSoundVolume2:ButtonContainer;
      
      public var btn_ambientSoundVolume3:ButtonContainer;
      
      public var btn_ambientSoundVolume4:ButtonContainer;
      
      public var btn_ambientSoundVolume5:ButtonContainer;
      
      public var btn_ambientSoundMute:ButtonContainer;
      
      public var input_bus1:Object;
      
      public var input_bus2:Object;
      
      public var input_bus3:Object;
      
      public var input_bus4:Object;
      
      public var input_bus5:Object;
      
      public var input_bus6:Object;
      
      public var input_bus7:Object;
      
      public var input_bus8:Object;
      
      public var soundOptionCtr:GraphicContainer;
      
      public var lbl_updater:TextArea;
      
      private var _textfieldDico:Dictionary;
      
      public function main(args:*) : void {
         var properties:Array = new Array();
         properties.push(new ConfigProperty("btn_activateSounds","tubulIsDesactivated","tubul"));
         properties.push(new ConfigProperty("","volumeMusic","tubul"));
         properties.push(new ConfigProperty("","volumeSound","tubul"));
         properties.push(new ConfigProperty("","volumeAmbientSound","tubul"));
         properties.push(new ConfigProperty("btn_musicMute","muteMusic","tubul"));
         properties.push(new ConfigProperty("btn_soundMute","muteSound","tubul"));
         properties.push(new ConfigProperty("btn_ambientSoundMute","muteAmbientSound","tubul"));
         properties.push(new ConfigProperty("btn_playSoundForGuildMessage","playSoundForGuildMessage","tubul"));
         properties.push(new ConfigProperty("btn_playSoundAtTurnStart","playSoundAtTurnStart","tubul"));
         properties.push(new ConfigProperty("btn_infiniteLoopMusics","infiniteLoopMusics","tubul"));
         init(properties);
         sysApi.addHook(ActivateSound,this.onActivateSound);
         uiApi.addComponentHook(this.btn_activateSounds,"onRelease");
         uiApi.addComponentHook(this.btn_musicVolume1,"onRelease");
         uiApi.addComponentHook(this.btn_musicVolume2,"onRelease");
         uiApi.addComponentHook(this.btn_musicVolume3,"onRelease");
         uiApi.addComponentHook(this.btn_musicVolume4,"onRelease");
         uiApi.addComponentHook(this.btn_musicVolume5,"onRelease");
         uiApi.addComponentHook(this.btn_musicMute,"onRelease");
         uiApi.addComponentHook(this.btn_soundVolume1,"onRelease");
         uiApi.addComponentHook(this.btn_soundVolume2,"onRelease");
         uiApi.addComponentHook(this.btn_soundVolume3,"onRelease");
         uiApi.addComponentHook(this.btn_soundVolume4,"onRelease");
         uiApi.addComponentHook(this.btn_soundVolume5,"onRelease");
         uiApi.addComponentHook(this.btn_soundMute,"onRelease");
         uiApi.addComponentHook(this.btn_ambientSoundVolume1,"onRelease");
         uiApi.addComponentHook(this.btn_ambientSoundVolume2,"onRelease");
         uiApi.addComponentHook(this.btn_ambientSoundVolume3,"onRelease");
         uiApi.addComponentHook(this.btn_ambientSoundVolume4,"onRelease");
         uiApi.addComponentHook(this.btn_ambientSoundVolume5,"onRelease");
         uiApi.addComponentHook(this.btn_ambientSoundMute,"onRelease");
         this._textfieldDico = new Dictionary();
         this.displayUpdate();
      }
      
      override public function reset() : void {
         super.reset();
         this.displayUpdate();
      }
      
      public function unload() : void {
      }
      
      public function displayUpdate() : void {
         var index:uint = 0;
         var musicBtns:Array = [this.btn_musicVolume1,this.btn_musicVolume2,this.btn_musicVolume3,this.btn_musicVolume4,this.btn_musicVolume5];
         var soundBtns:Array = [this.btn_soundVolume1,this.btn_soundVolume2,this.btn_soundVolume3,this.btn_soundVolume4,this.btn_soundVolume5];
         var ambientSoundBtns:Array = [this.btn_ambientSoundVolume1,this.btn_ambientSoundVolume2,this.btn_ambientSoundVolume3,this.btn_ambientSoundVolume4,this.btn_ambientSoundVolume5];
         var volMusic:Number = sysApi.getOption("volumeMusic","tubul");
         var volSound:Number = sysApi.getOption("volumeSound","tubul");
         var volAmbientSound:Number = sysApi.getOption("volumeAmbientSound","tubul");
         this.btn_musicMute.selected = sysApi.getOption("muteMusic","tubul");
         this.btn_soundMute.selected = sysApi.getOption("muteSound","tubul");
         this.btn_ambientSoundMute.selected = sysApi.getOption("muteAmbientSound","tubul");
         this.btn_playSoundForGuildMessage.selected = sysApi.getOption("playSoundForGuildMessage","tubul");
         this.btn_playSoundAtTurnStart.selected = sysApi.getOption("playSoundAtTurnStart","tubul");
         this.btn_infiniteLoopMusics.selected = sysApi.getOption("infiniteLoopMusics","tubul");
         this.btn_activateSounds.selected = sysApi.getOption("tubulIsDesactivated","tubul");
         sysApi.log(2," options de tubul : music " + sysApi.getOption("volumeMusic","tubul") + ", son " + sysApi.getOption("volumeSound","tubul") + ", son d\'ambiance " + sysApi.getOption("volumeAmbientSound","tubul") + "   --> tubul desactivé " + sysApi.getOption("tubulIsDesactivated","tubul"));
         if(volMusic > 0)
         {
            index = Math.round(volMusic / 0.2 * 10) / 10 - 1;
            musicBtns[index].selected = true;
         }
         if(volSound > 0)
         {
            index = Math.round(volSound / 0.2 * 10) / 10 - 1;
            soundBtns[index].selected = true;
         }
         if(volAmbientSound > 0)
         {
            index = Math.round(volAmbientSound / 0.2 * 10) / 10 - 1;
            ambientSoundBtns[index].selected = true;
         }
         if(this.btn_musicMute.selected)
         {
            this.btn_musicMute.soundId = SoundEnum.CHECKBOX_CHECKED;
         }
         else
         {
            this.btn_musicMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
         }
         if(this.btn_soundMute.selected)
         {
            this.btn_soundMute.soundId = SoundEnum.CHECKBOX_CHECKED;
         }
         else
         {
            this.btn_soundMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
         }
         if(this.btn_ambientSoundMute.selected)
         {
            this.btn_ambientSoundMute.soundId = SoundEnum.CHECKBOX_CHECKED;
         }
         else
         {
            this.btn_ambientSoundMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
         }
         if(this.soundApi.updaterAvailable())
         {
            this.lbl_updater.text = uiApi.getText("ui.option.soundSocketAvailable");
         }
         else
         {
            this.lbl_updater.text = uiApi.getText("ui.option.soundSocketClosed");
         }
         this.activeOptions(this.btn_activateSounds.selected);
      }
      
      private function onVolChange(pEvent:Event) : void {
         if(pEvent.target.text == "")
         {
            pEvent.target.text = 0;
         }
         this.soundApi.setBusVolume(this._textfieldDico[pEvent.target.name],pEvent.target.text);
      }
      
      private function saveOptions() : void {
      }
      
      private function undoOptions() : void {
      }
      
      private function activeOptions(pActivate:Boolean) : void {
         this.soundOptionCtr.disabled = pActivate;
         sysApi.dispatchHook(ActivateSound,pActivate);
      }
      
      private function onActivateSound(pActive:Boolean) : void {
         this.soundOptionCtr.disabled = pActive;
         this.btn_activateSounds.selected = pActive;
      }
      
      override public function onRelease(target:Object) : void {
         super.onRelease(target);
         switch(target)
         {
            case this.btn_activateSounds:
               this.activeOptions(this.btn_activateSounds.selected);
               break;
            case this.btn_musicVolume1:
               setProperty("tubul","volumeMusic",0.2);
               break;
            case this.btn_musicVolume2:
               setProperty("tubul","volumeMusic",0.4);
               break;
            case this.btn_musicVolume3:
               setProperty("tubul","volumeMusic",0.6);
               break;
            case this.btn_musicVolume4:
               setProperty("tubul","volumeMusic",0.8);
               break;
            case this.btn_musicVolume5:
               setProperty("tubul","volumeMusic",1);
               break;
            case this.btn_musicMute:
               if(this.btn_musicMute.selected)
               {
                  this.btn_musicMute.soundId = SoundEnum.CHECKBOX_CHECKED;
                  setProperty("tubul","muteMusic",true);
               }
               else
               {
                  this.btn_musicMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
                  setProperty("tubul","muteMusic",false);
               }
               break;
            case this.btn_soundVolume1:
               setProperty("tubul","volumeSound",0.2);
               break;
            case this.btn_soundVolume2:
               setProperty("tubul","volumeSound",0.4);
               break;
            case this.btn_soundVolume3:
               setProperty("tubul","volumeSound",0.6);
               break;
            case this.btn_soundVolume4:
               setProperty("tubul","volumeSound",0.8);
               break;
            case this.btn_soundVolume5:
               setProperty("tubul","volumeSound",1);
               break;
            case this.btn_soundMute:
               if(this.btn_soundMute.selected)
               {
                  this.btn_soundMute.soundId = SoundEnum.CHECKBOX_CHECKED;
                  setProperty("tubul","muteSound",true);
               }
               else
               {
                  this.btn_soundMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
                  setProperty("tubul","muteSound",false);
               }
               break;
            case this.btn_ambientSoundVolume1:
               setProperty("tubul","volumeAmbientSound",0.2);
               break;
            case this.btn_ambientSoundVolume2:
               setProperty("tubul","volumeAmbientSound",0.4);
               break;
            case this.btn_ambientSoundVolume3:
               setProperty("tubul","volumeAmbientSound",0.6);
               break;
            case this.btn_ambientSoundVolume4:
               setProperty("tubul","volumeAmbientSound",0.8);
               break;
            case this.btn_ambientSoundVolume5:
               setProperty("tubul","volumeAmbientSound",1);
               break;
            case this.btn_ambientSoundMute:
               if(this.btn_ambientSoundMute.selected)
               {
                  this.btn_ambientSoundMute.soundId = SoundEnum.CHECKBOX_CHECKED;
                  setProperty("tubul","muteAmbientSound",true);
               }
               else
               {
                  this.btn_ambientSoundMute.soundId = SoundEnum.CHECKBOX_UNCHECKED;
                  setProperty("tubul","muteAmbientSound",false);
               }
               break;
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void {
         if(0)
         {
         }
      }
      
      public function onRollOver(target:Object) : void {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.btn_musicMute:
               tooltipText = uiApi.getText("ui.option.muteMusic");
               point = 3;
               relPoint = 5;
               break;
            case this.btn_soundMute:
               tooltipText = uiApi.getText("ui.option.muteSound");
               point = 3;
               relPoint = 5;
               break;
            case this.btn_ambientSoundMute:
               tooltipText = uiApi.getText("ui.option.muteAmbience");
               point = 3;
               relPoint = 5;
               break;
            case this.btn_ambientSoundVolume1:
            case this.btn_musicVolume1:
            case this.btn_soundVolume1:
               tooltipText = "20%";
               break;
            case this.btn_ambientSoundVolume2:
            case this.btn_musicVolume2:
            case this.btn_soundVolume2:
               tooltipText = "40%";
               break;
            case this.btn_ambientSoundVolume3:
            case this.btn_musicVolume3:
            case this.btn_soundVolume3:
               tooltipText = "60%";
               break;
            case this.btn_ambientSoundVolume4:
            case this.btn_musicVolume4:
            case this.btn_soundVolume4:
               tooltipText = "80%";
               break;
            case this.btn_ambientSoundVolume5:
            case this.btn_musicVolume5:
            case this.btn_soundVolume5:
               tooltipText = "100%";
               break;
         }
         uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:Object) : void {
         uiApi.hideTooltip();
      }
   }
}
