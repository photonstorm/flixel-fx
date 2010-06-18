package
{
	import flash.utils.ByteArray;
	import flash.media.SoundTransform;
	
	import neoart.flod.*;
	
	public class FlxFlod
	{
		static private var modStream:ByteArray;
		static public var processor:ModProcessor;
		static private var soundform:SoundTransform = new SoundTransform();
		
		static public function playMod(toon:Class):void
		{
			stopMod();
			
			modStream = new toon() as ByteArray;
			
			processor = new ModProcessor();
			
			if (processor.load(modStream))
			{
				processor.loopSong = true;
				processor.stereo = 0;
				processor.play();
				
				if (processor.soundChannel)
				{
					//soundform.volume = FlxG.volume;
					processor.soundChannel.soundTransform = soundform;
				}
			}
		}
		
		static public function stopMod():void
		{
			if (processor)
			{
				processor.stop();
			}
		}
		
	}

}