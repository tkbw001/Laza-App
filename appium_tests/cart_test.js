async function cartTest() {
  const client = await wdio.remote(opts);

  // 1. Click on first product
  const product = await client.$('(//android.view.View)[1]');
  await product.click();

  // 2. Click Add to Cart
  const addBtn = await client.$('//android.widget.Button[@text="Add to Cart"]');
  await addBtn.click();

  // 3. Go to Cart Screen
  const cartIcon = await client.$('~CartIcon'); // Assuming accessibility id
  await cartIcon.click();

  // 4. Verify Item exists
  const cartItem = await client.$('//android.widget.TextView[contains(@text, "$")]');
  await expect(cartItem).toBeDisplayed();

  await client.deleteSession();
}

cartTest();