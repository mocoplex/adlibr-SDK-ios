using System.Runtime.InteropServices;
using UnityEngine;

public class AdlibPluginiOS {

	// These are the interface to native implementation calls for iOS.
	[DllImport("__Internal")]
	extern static public void _SetCallbackHandlerName(string handlerName);

	[DllImport("__Internal")]
	extern static public void _Initialize(string adlibKey);
	
	[DllImport("__Internal")]
	private static extern void _ShowBanner(bool positionAtTop);
	
	[DllImport("__Internal")]
	private static extern void _HideBanner();

	[DllImport("__Internal")]
	private static extern void _LoadInterstitialAd();
	
	public static void Initialize(string adlibKey)
	{
		_Initialize(adlibKey);
	}

	public static void SetCallbackHandlerName(string handlerName)
	{
		_SetCallbackHandlerName(handlerName);
	}

	public static void ShowBanner(bool positionAtTop)
	{
		_ShowBanner(positionAtTop);
	}
	
	public static void HideBanner()
	{
		_HideBanner();
	}

	public static void LoadInterstitialAd()
	{
		_LoadInterstitialAd();
	}
}
