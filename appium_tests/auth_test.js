const wdio = require('webdriverio');
const opts = {
  path: '/wd/hub',
  port: 4723,
  capabilities: {
    platformName: "Android",
    automationName: "UiAutomator2",
    deviceName: "Android Emulator",
    app: "/path/to/app.apk" // Update this path
  }
};

async function authTest() {
  const client = await wdio.remote(opts);
  
  // 1. Click on Login Button
  const loginBtn = await client.$('~Login');
  await loginBtn.click();

  // 2. Enter Email
  const emailField = await client.$('//android.widget.EditText[@text="Email Address"]');
  await emailField.setValue("test@laza.com");

  // 3. Enter Password
  const passField = await client.$('//android.widget.EditText[@text="Password"]');
  await passField.setValue("123456");

  // 4. Submit
  const submitBtn = await client.$('//android.widget.Button[@text="Login"]');
  await submitBtn.click();

  // 5. Verify Home Screen
  const homeTitle = await client.$('//android.widget.TextView[@text="Laza"]');
  await expect(homeTitle).toBeDisplayed();

  await client.deleteSession();
}

authTest();