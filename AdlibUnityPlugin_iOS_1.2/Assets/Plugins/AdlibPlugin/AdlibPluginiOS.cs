using System.Runtime.InteropServices;
using UnityEngine;

public class AdlibPluginiOS {

	// These are the interface to native implementation calls for iOS.
	[DllImport("__Internal")]
	extern static public void _SetCallbackHandlerName(string handlerName);

	[DllImport("__Internal")]
	extern static public void _Initialize(string adlibKey);
	
	[DllImport("__Internal")]
	private static extern void _ShowBanner(bool positionAtTop, bool useHouseBanner);
	
	[DllImport("__Internal")]
	private static extern void _HideBanner();

	[DllImport("__Internal")]
	private static extern void _LoadInterstitialAd();

	[DllImport("__Internal")]
	private static extern void _ShowPopBanner(string frameColor, string btnColor, bool useInAnim, bool useOutAnim, string btnAlign, int padding);

	[DllImport("__Internal")]
	private static extern void _HidePopBanner();

	[DllImport("__Internal")]
	private static extern void _ShowRewardLink(string linkId, int posX, int posY);
	
	[DllImport("__Internal")]
	private static extern void _HideRewardLink();
	
	public static void Initialize(string adlibKey)
	{
		_Initialize(adlibKey);
	}

	public static void SetCallbackHandlerName(string handlerName)
	{
		_SetCallbackHandlerName(handlerName);
	}

	public static void ShowBanner(bool positionAtTop, bool useHouseBanner)
	{
		_ShowBanner(positionAtTop, useHouseBanner);
	}
	
	public static void HideBanner()
	{
		_HideBanner();
	}

	public static void LoadInterstitialAd()
	{
		_LoadInterstitialAd();
	}

	public static void ShowPopBanner(string frameColor, string btnColor, bool useInAnim, bool useOutAnim, string btnAlign, int padding)
	{
		_ShowPopBanner(frameColor, btnColor, useInAnim, useOutAnim, btnAlign, padding);
	}

	public static void HidePopBanner()
	{
		_HidePopBanner();
	}

	public static void ShowRewardLink(string linkId, int posX, int posY)
	{
		_ShowRewardLink(linkId, posX, posY);
	}
	
	public static void HideRewardLink()
	{
		_HideRewardLink();
	}
}
