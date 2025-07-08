/*
  Warnings:

  - You are about to drop the column `menuId` on the `transaction` table. All the data in the column will be lost.
  - You are about to drop the column `quantity` on the `transaction` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "transaction" DROP CONSTRAINT "transaction_menuId_fkey";

-- DropIndex
DROP INDEX "transaction_menuId_idx";

-- AlterTable
ALTER TABLE "transaction" DROP COLUMN "menuId",
DROP COLUMN "quantity",
ADD COLUMN     "paymentMethod" VARCHAR(50);

-- CreateTable
CREATE TABLE "transactionItem" (
    "id" TEXT NOT NULL,
    "transactionId" TEXT NOT NULL,
    "menuId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "totalPrice" INTEGER NOT NULL,
    "status" VARCHAR(50) NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "transactionItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "transactionItem_transactionId_idx" ON "transactionItem"("transactionId");

-- CreateIndex
CREATE INDEX "transactionItem_menuId_idx" ON "transactionItem"("menuId");

-- AddForeignKey
ALTER TABLE "transactionItem" ADD CONSTRAINT "transactionItem_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES "transaction"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactionItem" ADD CONSTRAINT "transactionItem_menuId_fkey" FOREIGN KEY ("menuId") REFERENCES "Menu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
