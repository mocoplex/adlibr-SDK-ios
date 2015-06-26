using System;
using System.ComponentModel;
using System.Collections;
using System.Runtime.InteropServices;
using UnityEngine;

using AdlibMobilePlugin = AdlibPluginiOS;

public class AdlibPlugin : MonoBehaviour {

	public static event Action<string> ReceivedInterstitial = delegate {};
	public static event Action FailedToReceiveInterstitial = delegate {};
	public static event Action DismissedInterstitial = delegate {};
	
	void Awake() {
		gameObject.name = this.GetType().ToString();
		SetCallbackHandlerName(gameObject.name);
		DontDestroyOnLoad(this);
	}
	
	public static void InitializeAdlib(string adlibKey) {
		// Call plugin only when running on real device.
		if (Application.platform == RuntimePlatform.OSXEditor)
		{
			return;
		}
		AdlibMobilePlugin.Initialize(adlibKey);
	}
	
	public static void SetCallbackHandlerName(string name) {
		if (Application.platform == RuntimePlatform.OSXEditor)
		{
			return;
		}
		AdlibMobilePlugin.SetCallbackHandlerName(name);
	}
	
	public static void ShowBanner(bool positionAtTop) {
		AdlibMobilePlugin.ShowBanner(positionAtTop);
	}
	
	public static void HideBanner() {
		AdlibMobilePlugin.HideBanner();
	}
	
	public static void LoadInterstitialAd() {
		AdlibMobilePlugin.LoadInterstitialAd();
	}
	
	public void OnReceivedInterstitialAd(string platform)
	{
		ReceivedInterstitial(platform);
	}
	
	public void OnFailedToReceiveInterstitialAd(string unusedMessage)
	{
		FailedToReceiveInterstitial();
	}
	
	public void OnClosedInterstitialAd(string unusedMessage)
	{
		DismissedInterstitial();
	}
}