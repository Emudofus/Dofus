package com.ankamagames.berilia.utils.web
{
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.filesystem.FileStream;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.filesystem.File;
   import flash.events.FileListEvent;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.filesystem.FileMode;
   
   public class HttpResponder extends Object
   {
      
      public function HttpResponder(socket:Socket, httpVerb:String, relativeFilePath:String, serverRoot:String) {
         var fileToServe:File = null;
         var hj:String = null;
         var fileModifiedDate:Date = null;
         super();
         this._socket = socket;
         if((!(httpVerb == HttpResponder.HTTP_VERB_GET)) && (!(httpVerb == HttpResponder.HTTP_VERB_HEAD)))
         {
            this.throw501();
         }
         if(httpVerb == HttpResponder.HTTP_VERB_HEAD)
         {
            this._includeContent = false;
         }
         this._responseBytes = new ByteArray();
         if(relativeFilePath.indexOf("?") != -1)
         {
            relativeFilePath = relativeFilePath.substring(0,relativeFilePath.indexOf("?"));
         }
         var relativeFilePath:String = decodeURI(relativeFilePath);
         relativeFilePath = StringUtils.convertLatinToUtf(relativeFilePath);
         if((!(relativeFilePath.indexOf("../") == -1)) || (!(relativeFilePath.indexOf("..\\") == -1)))
         {
            this.throw403();
         }
         relativeFilePath = relativeFilePath.split("file://").join("");
         while(relativeFilePath.charAt(0) == ".")
         {
            relativeFilePath = relativeFilePath.substr(1);
         }
         while(relativeFilePath.charAt(0) == "/")
         {
            relativeFilePath = relativeFilePath.substr(1);
         }
         var rootDirectory:File = new File(serverRoot);
         if(rootDirectory.exists)
         {
            hj = File.applicationDirectory.nativePath;
            fileToServe = rootDirectory.resolvePath(relativeFilePath);
            if(fileToServe.exists)
            {
               if(fileToServe.isDirectory)
               {
                  this._dateHeader = "Date: " + this.toRFC802(new Date());
                  this._mimeHeader = "Content-Type: text/html";
                  fileToServe.addEventListener(FileListEvent.DIRECTORY_LISTING,this.onDirectoryList);
                  fileToServe.getDirectoryListingAsync();
               }
               else
               {
                  fileModifiedDate = fileToServe.modificationDate;
                  this._dateHeader = "Date: " + this.toRFC802(fileModifiedDate);
                  this._mimeHeader = this.getMimeHeader(fileToServe);
                  this._stream = new FileStream();
                  this._stream.addEventListener(Event.COMPLETE,this.onFileReadDone);
                  this._stream.addEventListener(IOErrorEvent.IO_ERROR,this.onFileIoError);
                  this._stream.openAsync(fileToServe,FileMode.READ);
               }
            }
            else
            {
               this.throw404();
            }
         }
         else
         {
            this.throw404();
         }
      }
      
      private static const HTTP_VERB_GET:String = "GET";
      
      private static const HTTP_VERB_HEAD:String = "HEAD";
      
      private static const HTTP_VERB_POST:String = "POST";
      
      private var _socket:Socket;
      
      private var _responseBytes:ByteArray;
      
      private var _contentBytes:ByteArray;
      
      private var _stream:FileStream;
      
      private var _mimeHeader:String;
      
      private var _statusHeader:String;
      
      private var _dateHeader:String;
      
      private var _contentLengthHeader:String;
      
      private var _includeContent:Boolean = true;
      
      private const HEADER_SEPERATOR:String = "\n";
      
      private const HEADER_END_SEPERATOR:String = "\n\n";
      
      private function onFileIoError(e:Event) : void {
         this._stream.removeEventListener(Event.COMPLETE,this.onFileReadDone);
         this._stream.removeEventListener(IOErrorEvent.IO_ERROR,this.onFileIoError);
         this._stream.close();
         this._dateHeader = null;
         this.throw404();
      }
      
      private function onFileReadDone(e:Event) : void {
         this._stream.removeEventListener(Event.COMPLETE,this.onFileReadDone);
         this._stream.removeEventListener(IOErrorEvent.IO_ERROR,this.onFileIoError);
         this._contentBytes = new ByteArray();
         this._stream.readBytes(this._contentBytes,0,this._stream.bytesAvailable);
         this._stream.close();
         this._statusHeader = "HTTP/1.0 200 OK";
         this._contentBytes.position = 0;
         this._contentLengthHeader = "Content-Length: " + this._contentBytes.bytesAvailable;
         this.sendResponse();
      }
      
      private function getRelativePath(f:File) : String {
         var rootPath:String = new File(HttpServer.getInstance().rootPath).nativePath;
         return f.nativePath.substring(rootPath.length + 1).split("\\").join("/");
      }
      
      private function getImg(f:File) : String {
         var img:String = "<img src=\"data:image/png;base64,";
         if(f.isDirectory)
         {
            img = img + "iVBORw0KGgoAAAANSUhEUgAAAA4AAAALCAYAAABPhbxiAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH1gcFERo3mDnvIwAAAYBJREFUeNp9j71qFVEUhb9zcu44inMJKKJBEaxugqUEhHT6HjY+gI1YCIKN4BNYCj6CWIr4CMFKERuDmMSfO3P/MnP+lsWMuVauZm8Wa+21l/n05tZ+Od7ZMcayhujmXw5SrG8DHf/CALB0RnZybe/lyBgD6k0YQ2x/3jjaf3qggQXYKMZSCseL7+8eOqJasj/THb4g+Q2wY4ypKLfusLX7vEACMigDwtjzlz+/3nviCMYqe5IvUBb55CthecTi+D2j8gooQPZIEYhUk0cFytcdRmWOJ/gVyC8J8xnV5B7lhe2h0N9E9YluE5J1jmBxZy+xuX3/VCAy2X8j1m9RalBsUJyhtKC8+hg64QiSUktefehFaY5iTQ5TlBqI9cDPUFqCOgjg6JByJIcf/eXUoFgP+3RImp0apQgdOLxkSCj+Hgz1+r3UoDhfm3Lb14ng5PM0rn6dC4uiIldWGkGuQBdR6gCPbD+NTaS2lXzuzMdnNx9gzS7iLoaK/0GAwZP16g/A9xHVPFbSAQAAAABJRU5ErkJggg%3D%3D";
         }
         else
         {
            switch(f.extension)
            {
               case "swf":
               case "swfs":
                  img = img + "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAHYSURBVDjLjZPLSxtRFMa1f0UXCl0VN66igg80kQZtsLiUWhe14MKFIFHbIEF8BNFFKYVkkT9GKFJooXTToq2gLkQT82oyjzuvO8nXe65mmIkRHfg2c+/3O+d8l9MBoIMkvi6hkNDAA3om9MTz+QAhy7JqnPO667poJ3GOdDr92Q/xAwbIrOs6GGOeFEVBtVpFoVCQkHw+j0wm40Ga5k4C0AXTNGHbNsxv32Hu7YNtp1Cr1VAsFiXAMAxQkWw2ewNpBZDZPjiA+XYebioJ9nIKqqqiVCrdGUlm0gpwzs5hzrwGX1uGMTMLtvrBG6VcLstOcrncPQDOYW3tgCffw0isg4uqnP6J8AhCnVAelUqlPYD/PYE59wZ67BXsL4fg/6ryYhNC82uaJkFtAdbHT+CJFbgbCagjYbDNlDev4zgyH4KQ7gA2n/fMUWWeiAtzBMrgWABAXciAhaibAKAYnXyaGx3/5cSXoIajsH/8hHP8B87llTSSqAMSmQMAfSL2VYtET5WRCLcW3oHt7Aaq+s1+eQAt/EJXh8MNe2kRSmwa/LoQeOsmpFUeQB0ag9I/jIve0G/n6Lhx3x60Ud3L4DbIPhEQo4PHmMVdTW6vD9BNkEesc1O0+t3/AXamvvzW7S+UAAAAAElFTkSuQmCC";
                  break;
               case "png":
               case "jpg":
               case "jpeg":
                  img = img + "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAAHfSURBVDjLpZO9a5NhFMV/bxowYvNRjf1IoCDo0KFJBVHEVbeCi5N/gM6KruLi6KiDKA6KIC6CQwdtBxfRrUGHFlTQIlikjTFpkua55zo8r7aDipALd3keOOdwzrmJuzPMZF/cOPFXBMmRHJMTTJiJYCIEESy+ZQGqczPIDNxxd/AMDriBu+MSCkJmSA4CJ8Pym+UIIAs0177S3Wz9F3O+WGCiMrmjwM3pbrZ4fvo17kR237XAtcolRvdOA+L+9TscHB/HTGQAlLqwuHWbxa1b9JMVTBDSHRi82qijbgPXNsGEpx5kouYo+2jpI/3kCUudiwzUJBgMAoQAjf4ZFtZP0mq/x0xIYPJUQQoQLHAsX8fMeNk7y4DVCGKw0q7ytHmByx/u/lYgOVnJUbBomAa8azWYr5b50unRGZln48ccYzrH5/VTtHuTKIxQk8dUdgMEE/XyN2YPTFHJHaZWFPIan/KriEccqT5ExJi15FiwWCSTo+CYiYk9h5CL4NvIhSOmctOxCwgh3J3vauAWnc8GEzInt2+U3s1nuEWwmPlOByzthuSUSyV+XUDWTOAJxbEyhcJ+pPgxc/4KnbUFQOTKx3n74B5uQhI4JEkMMHl8ddZ3d/tfzH+aZNhrzDDk/ARfG6G/LNZPQgAAAABJRU5ErkJggg==";
                  break;
               case "xml":
               case "meta":
               case "metas":
                  img = img + "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAQAAAC1+jfqAAAABGdBTUEAAK/INwWK6QAAABl0RVh0U29mdHdhcmUAQWRvYmUgSW1hZ2VSZWFkeXHJZTwAAADoSURBVBgZBcExblNBGAbA2ceegTRBuIKOgiihSZNTcC5LUHAihNJR0kGKCDcYJY6D3/77MdOinTvzAgCw8ysThIvn/VojIyMjIyPP+bS1sUQIV2s95pBDDvmbP/mdkft83tpYguZq5Jh/OeaYh+yzy8hTHvNlaxNNczm+la9OTlar1UdA/+C2A4trRCnD3jS8BB1obq2Gk6GU6QbQAS4BUaYSQAf4bhhKKTFdAzrAOwAxEUAH+KEM01SY3gM6wBsEAQB0gJ+maZoC3gI6iPYaAIBJsiRmHU0AALOeFC3aK2cWAACUXe7+AwO0lc9eTHYTAAAAAElFTkSuQmCC";
                  break;
            }
         }
         return img + "\" />";
      }
      
      private function onDirectoryList(e:FileListEvent) : void {
         var f:File = null;
         var isDir:* = false;
         this._statusHeader = "HTTP/1.0 200 OK";
         var html:String = "<html><head><title>Dofus Module Server</title></head><body><h2>Index of /" + this.getRelativePath(File(e.target)) + "</h2><ul>";
         html = html + "<table><tr><td></td><td><b>Name</b></td><td><b>Last modified</b></td><td><b>Size (octet)</b></td></tr>";
         if(this.getRelativePath(File(e.target)) != "")
         {
            html = html + ("<tr><td>" + this.getImg(File(e.target).parent) + "</td><td><a href=\"" + HttpServer.getInstance().getUrlTo(this.getRelativePath(File(e.target).parent)) + "\">..</a></td><td>-</td><td>-</td></tr>");
         }
         for each (f in e.files)
         {
            isDir = f.isDirectory;
            html = html + ("<tr>" + "<td>" + this.getImg(f) + "</td>" + "<td><a href=\"" + HttpServer.getInstance().getUrlTo(this.getRelativePath(f)) + "\">" + f.name + (isDir?"/":"") + "</a></td>" + "<td>" + this.toRFC802(f.modificationDate) + "</td>" + "<td>" + (isDir?"-":f.size) + "</td>" + "</tr>");
         }
         html = html + "</table></body></html>";
         this._contentBytes = new ByteArray();
         this._contentBytes.writeUTFBytes(html);
         this._contentBytes.position = 0;
         this._contentLengthHeader = "Content-Length: " + this._contentBytes.bytesAvailable;
         this.sendResponse();
      }
      
      private function sendResponse() : void {
         this._responseBytes = new ByteArray();
         this._responseBytes.writeUTFBytes(this._statusHeader);
         this._responseBytes.writeUTFBytes(this.HEADER_SEPERATOR);
         if(this._dateHeader)
         {
            this._responseBytes.writeUTFBytes(this._dateHeader);
            this._responseBytes.writeUTFBytes(this.HEADER_SEPERATOR);
         }
         this._responseBytes.writeUTFBytes(this._mimeHeader);
         this._responseBytes.writeUTFBytes(this.HEADER_SEPERATOR);
         if(this._includeContent)
         {
            this._responseBytes.writeUTFBytes(this._contentLengthHeader);
         }
         this._responseBytes.writeUTFBytes(this.HEADER_END_SEPERATOR);
         if(this._includeContent)
         {
            this._responseBytes.writeBytes(this._contentBytes);
         }
         this._responseBytes.position = 0;
         this._socket.writeBytes(this._responseBytes,0,this._responseBytes.bytesAvailable);
         this._socket.flush();
      }
      
      private function throw404() : void {
         this._statusHeader = "HTTP/1.0 404 Not Found";
         this._mimeHeader = "Content-Type: text/html";
         var four0FourString:String = "<HTML><HEAD><TITLE>404 Not Found</TITLE></HEAD><BODY>404 Not Found</BODY></HTML>";
         this._contentBytes = new ByteArray();
         this._contentBytes.writeUTFBytes(four0FourString);
         this._contentBytes.position = 0;
         this._contentLengthHeader = "Content-Length: " + this._contentBytes.bytesAvailable;
         this.sendResponse();
      }
      
      private function throw403() : void {
         this._statusHeader = "HTTP/1.0 403 Forbidden";
         this._mimeHeader = "Content-Type: text/html";
         var four0FourString:String = "<HTML><HEAD><TITLE>403 Forbidden</TITLE></HEAD><BODY>403 Forbidden</BODY></HTML>";
         this._contentBytes = new ByteArray();
         this._contentBytes.writeUTFBytes(four0FourString);
         this._contentBytes.position = 0;
         this._contentLengthHeader = "Content-Length: " + this._contentBytes.bytesAvailable;
         this.sendResponse();
      }
      
      private function throw501() : void {
         this._statusHeader = "HTTP/1.0 501 Not Implemented";
         this._responseBytes = new ByteArray();
         this._responseBytes.writeUTFBytes(this._statusHeader);
         this._responseBytes.writeUTFBytes(this.HEADER_END_SEPERATOR);
         this._responseBytes.position = 0;
         this._socket.writeBytes(this._responseBytes,0,this._responseBytes.bytesAvailable);
      }
      
      private function throw500() : void {
         this._statusHeader = "HTTP/1.0 500 Internal Server Error";
         this._responseBytes = new ByteArray();
         this._responseBytes.writeUTFBytes(this._statusHeader);
         this._responseBytes.writeUTFBytes(this.HEADER_END_SEPERATOR);
         this._responseBytes.position = 0;
         this._socket.writeBytes(this._responseBytes,0,this._responseBytes.bytesAvailable);
      }
      
      private function getMimeHeader(file:File) : String {
         var extn:String = file.extension;
         return "Content-Type: " + MimeTypeHelper.getMimeType(extn);
      }
      
      private function toRFC802(date:Date) : String {
         var output:String = "";
         switch(date.dayUTC)
         {
            case 0:
               output = output + "Sun";
               break;
            case 1:
               output = output + "Mon";
               break;
            case 2:
               output = output + "Tue";
               break;
            case 3:
               output = output + "Wed";
               break;
            case 4:
               output = output + "Thu";
               break;
            case 5:
               output = output + "Fri";
               break;
            case 6:
               output = output + "Sat";
               break;
         }
         output = output + ", ";
         if(date.dateUTC < 10)
         {
            output = output + "0";
         }
         output = output + (date.dateUTC + " ");
         switch(date.month)
         {
            case 0:
               output = output + "Jan";
               break;
            case 1:
               output = output + "Feb";
               break;
            case 2:
               output = output + "Mar";
               break;
            case 3:
               output = output + "Apr";
               break;
            case 4:
               output = output + "May";
               break;
            case 5:
               output = output + "Jun";
               break;
            case 6:
               output = output + "Jul";
               break;
            case 7:
               output = output + "Aug";
               break;
            case 8:
               output = output + "Sep";
               break;
            case 9:
               output = output + "Oct";
               break;
            case 10:
               output = output + "Nov";
               break;
            case 11:
               output = output + "Dec";
               break;
         }
         output = output + " ";
         output = output + (date.fullYearUTC + " ");
         if(date.hoursUTC < 10)
         {
            output = output + "0";
         }
         output = output + (date.hoursUTC + ":");
         if(date.minutesUTC < 10)
         {
            output = output + "0";
         }
         output = output + (date.minutesUTC + ":");
         if(date.seconds < 10)
         {
            output = output + "0";
         }
         output = output + (date.secondsUTC + " GMT");
         return output;
      }
   }
}
